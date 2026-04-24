import 'dart:io';

import 'package:mascot/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot/app_routes.dart';

class Logged extends StatefulWidget {
  const Logged({super.key});

  @override
  State<Logged> createState() => _LoggedState();
}

class _LoggedState extends State<Logged> {
  bool yukleniyor = false;

  Future<File?> fotoSec() async {
    final value = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (value == null) {
      return null;
    }
    return File(value.path);
  }

  Future<String> storageYukle(File file) async {
    final dosyaAdi = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instanceFor(
      bucket: DefaultFirebaseOptions.currentPlatform.storageBucket,
    ).ref().child('posts').child(dosyaAdi);
    await ref.putFile(file);
    return ref.getDownloadURL();
  }

  Future<void> firestoreKaydet(String downloadUrl) async {
    await FirebaseFirestore.instance.collection('posts').add({
      'email': FirebaseAuth.instance.currentUser?.email,
      'downloadUrl': downloadUrl,
      'comments': [],
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> downloadStorage() async {
    setState(() {
      yukleniyor = true;
    });
    try {
      if (FirebaseAuth.instance.currentUser == null) {
        throw FirebaseAuthException(
          code: 'not-signed-in',
          message: 'Önce giriş yapman gerekiyor',
        );
      }
      final secilen = await fotoSec();
      if (secilen == null) {
        return;
      }
      final downloadUrl = await storageYukle(secilen);
      await firestoreKaydet(downloadUrl);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Fotoğraf yüklendi')));
    } on FirebaseException catch (e) {
      if (!mounted) return;
      final msg =
          'Hata: ${e.code}${e.message == null ? '' : ' - ${e.message}'}';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          yukleniyor = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticated'),
        actions: [
          Text(
            'Login Successful',
            style: TextStyle(
              fontFamily: 'Antonio',
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.register, (route) => false);
              } on FirebaseAuthException catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
              } catch (_) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Çıkış yapılırken hata oluştu')),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('Henüz gönderi yok'));
            }
            final docs = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 90),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index];
                final data = Map<String, dynamic>.from(doc.data() as Map);
                final email = (data['email'] ?? '').toString();
                final imageUrl = (data['downloadUrl'] ?? '').toString();
                final commentsRaw = data['comments'];
                final comments = commentsRaw is List
                    ? commentsRaw.map((e) => e.toString()).toList()
                    : <String>[];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          email.isEmpty ? 'Anonim' : email,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 8),
                        ...comments.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text('• $e'),
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'Yorum ekle',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onSubmitted: (v) async {
                            final t = v.trim();
                            if (t.isNotEmpty) {
                              try {
                                await FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(doc.id)
                                    .update({
                                      'comments': FieldValue.arrayUnion([t]),
                                    });
                              } on FirebaseException catch (e) {
                                if (!context.mounted) return;
                                final msg = e.message ?? e.code;
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(msg)));
                              } catch (_) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Yorum eklenirken hata oluştu',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: yukleniyor ? null : downloadStorage,
        child: yukleniyor
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add_a_photo),
      ),
    );
  }
}
