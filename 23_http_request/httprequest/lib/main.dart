import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:httprequest/model/message_model.dart';

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
      home: const FetchMessage(),
    );
  }
}

class FetchMessage extends StatefulWidget {
  const FetchMessage({super.key});

  @override
  State<FetchMessage> createState() => _FetchMessageState();
}

class _FetchMessageState extends State<FetchMessage> {
  late Future<MessageModel> futureMessage;

  @override
  void initState() {
    super.initState();
    futureMessage = fetchMessageFromApi();
  }

  Future<MessageModel> fetchMessageFromApi() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/quotes/random'),
    );

    if (response.statusCode == 200) {
      return MessageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fetch Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Antonio',
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.pink[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gelecek olan mesajı saran bölüm
          Expanded(
            child: Center(
              child: FutureBuilder<MessageModel>(
                future: futureMessage,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              snapshot.data!.quote,
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '- ${snapshot.data!.author}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator(color: Colors.pink);
                },
              ),
            ),
          ),
          // Buton her zaman en altta veya ortada sabit kalır
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              onPressed: () {
                setState(() {
                  futureMessage = fetchMessageFromApi();
                });
              },

              child: const Text(
                'Yeni Mektup Gönder 💌',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
