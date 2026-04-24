import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pickers/image_picker.dart';
import 'package:pickers/profile_provider.dart';
import 'package:pickers/update_color.dart';
import 'package:pickers/update_font.dart';
import 'package:pickers/update_profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Pickers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Profil Kartım'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: profileProvider.backgroundColor,
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 58,
                      backgroundImage: profileProvider.profilePicture.isNotEmpty
                          ? FileImage(File(profileProvider.profilePicture))
                          : null,
                      child: profileProvider.profilePicture.isEmpty
                          ? const Icon(Icons.person, size: 58)
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profileProvider.name,
                      style: TextStyle(
                        fontFamily: profileProvider.fontStyle,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${profileProvider.age} yaşında',
                      style: TextStyle(
                        fontFamily: profileProvider.fontStyle,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            _ActionTile(
              icon: Icons.font_download_rounded,
              title: 'Yazı Tipini Değiştir',
              subtitle: 'İlk sayfadaki etiket yazı tipini güncelle',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateFontPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.palette_rounded,
              title: 'Arka Plan Rengi Seç',
              subtitle: 'Ayrıca açılan ekranda renk seçimi yap',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateColorPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            _ActionTile(
              icon: Icons.cake_rounded,
              title: 'Yaşı Tarih ile Belirle',
              subtitle: 'Doğum tarihini seçerek yaşı hesapla',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImagePickerPage()),
          );
        },
        tooltip: 'Foto Seç',
        child: const Icon(Icons.add_a_photo_rounded),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(icon),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
