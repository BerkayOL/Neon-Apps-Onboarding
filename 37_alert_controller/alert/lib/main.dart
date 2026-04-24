import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Gizemli Uyarı'),
                      content: const Text(
                        'Bu uyarıda hiçbir buton yok! Kapatmak için boşluğa tıkla.',
                      ),
                    );
                  },
                );
              },
              child: const Text('Buttonsuz Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Tek Butonlu Uyarı'),
                      content: const Text(
                        'Bu uyarıda sadece bir buton var. Kapatmak için butona tıkla.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            print('Kapat');
                            Navigator.of(context).pop();
                          },
                          child: const Text('Kapat'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Tek Butonlu Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('İki Butonlu Uyarı'),
                      content: const Text(
                        'Bu uyarıda iki buton var. Kapatmak için birine tıkla.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            print('İptal');
                            Navigator.of(context).pop();
                          },
                          child: const Text('İptal'),
                        ),
                        TextButton(
                          onPressed: () {
                            print('Onayla');
                            Navigator.of(context).pop();
                          },
                          child: const Text('Onayla'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('İki Butonlu Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('TextField Alert'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Fikrini bizimle paylaş (Alt Başlık)'),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _textController,
                            decoration: const InputDecoration(
                              hintText: 'Lütfen bir metin girin',
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            print(_textController.text);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yazdır ve Kapat'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('TextField Alert'),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Action Sheet Başlığı',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Aşağıdan bir eylem seçin.'),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.star),
                            title: const Text('Seçenek 1'),
                            onTap: () {
                              print('Seçenek 1 seçildi');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: const Text('Seçenek 2'),
                            onTap: () {
                              print('Seçenek 2 seçildi');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Action Sheet'),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Activity Controller Başlığı',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text('Paylaşım yöntemini belirleyin.'),
                              ],
                            ),
                          ),
                          ListTile(
                            leading: const Icon(Icons.insert_drive_file),
                            title: const Text('Dosya Paylaş'),
                            onTap: () {
                              print('Dosya Paylaşıldı!');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.share),
                            title: const Text('Resim Paylaş'),
                            onTap: () {
                              print('Resim Paylaşıldı!');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Activity Controller'),
            ),
          ],
        ),
      ),
    );
  }
}
