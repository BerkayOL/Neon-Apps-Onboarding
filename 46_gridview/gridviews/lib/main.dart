import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gridviews/neonapp.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neon Apps',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F7FA),
      ),
      home: const MyHomePage(title: 'Neon Apps Gallery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _gridRatio = 0.75;
  List<NeonApp> apps = [
    NeonApp(
      appIcon: 'assets/images/instagram.png',
      appName: 'Instagram',
      releaseDate: '2010-10-06',
      appCategory: 'Category 1',
      storeURL:
          'https://play.google.com/store/apps/details?id=com.instagram.android&hl=tr',
    ),
    NeonApp(
      appIcon: 'assets/images/facebook.png',
      appName: 'Facebook',
      releaseDate: '2004-02-04',
      appCategory: 'Category 2',
      storeURL:
          'https://play.google.com/store/apps/details?id=com.facebook.katana&hl=tr',
    ),
    NeonApp(
      appIcon: 'assets/images/whatsapp.png',
      appName: 'WhatsApp',
      releaseDate: '2009-01-24',
      appCategory: 'Category 3',
      storeURL:
          'https://play.google.com/store/apps/details?id=com.whatsapp&hl=tr',
    ),
  ];

  Future<void> _refreshApps() async {
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() {
      apps = List<NeonApp>.from(apps)..shuffle();
    });
  }

  void _openSizeControl() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Size For Item',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current ratio: ${_gridRatio.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Slider(
                    min: 0.60,
                    max: 1.20,
                    divisions: 12,
                    value: _gridRatio,
                    label: _gridRatio.toStringAsFixed(2),
                    onChanged: (value) {
                      setSheetState(() {
                        _gridRatio = value;
                      });
                      setState(() {
                        _gridRatio = value;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F766E), Color(0xFF1D4ED8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.tune), onPressed: _openSizeControl),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _refreshApps,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FCFF), Color(0xFFEAF2F9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          color: const Color(0xFF1D4ED8),
          onRefresh: _refreshApps,
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 18),
            itemCount: apps.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: _gridRatio,
            ),
            itemBuilder: (context, index) {
              final app = apps[index];
              return CupertinoContextMenu(
                actions: [
                  CupertinoContextMenuAction(
                    trailingIcon: CupertinoIcons.share,
                    child: const Text('Share'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                child: InkWell(
                  borderRadius: BorderRadius.circular(22),
                  onTap: () {
                    setState(() {
                      app.isSelected = !app.isSelected;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NeonAppDetailPage(app: app),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: app.isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFFE9F5FF), Color(0xFFDDF4EC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : const LinearGradient(
                              colors: [Colors.white, Color(0xFFF9FBFD)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                      border: Border.all(
                        color: app.isSelected
                            ? const Color(0xFF22C55E)
                            : const Color(0xFFD6DEE8),
                        width: app.isSelected ? 1.7 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF0F172A,
                          ).withValues(alpha: 0.08),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(
                                tag: app.appName,
                                child: Image.asset(
                                  app.appIcon,
                                  height: 72,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.image, size: 72),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                app.appName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                app.releaseDate,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                app.appCategory,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF334155),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (app.isSelected)
                          const Positioned(
                            right: 0,
                            top: 0,
                            child: Icon(
                              Icons.check_circle,
                              color: Color(0xFF16A34A),
                              size: 22,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class NeonAppDetailPage extends StatelessWidget {
  final NeonApp app;
  const NeonAppDetailPage({super.key, required this.app});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(app.appName), centerTitle: true),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FCFF), Color(0xFFEFF4FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: app.appName,
                child: Image.asset(
                  app.appIcon,
                  height: 160,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 160),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              app.appName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFD9E2EC)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Release Date: ${app.releaseDate}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${app.appCategory}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Store URL: ${app.storeURL}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  final Uri url = Uri.parse(app.storeURL);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    debugPrint('Could not launch $url');
                  }
                },
                icon: const Icon(Icons.open_in_new),
                label: const Text('Open in Store'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
