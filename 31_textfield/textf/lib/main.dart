import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text Field Academy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Text Field Academy'),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF4F7FF), Color(0xFFE9F0FF), Color(0xFFFDFEFF)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Create Your Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontFamily: 'Antonio',
                              fontWeight: FontWeight.bold,
                            ),
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Name-Surname',
                              labelText: 'Enter Name-Surname',
                              hintStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontFamily: 'Antonio',
                                fontWeight: FontWeight.bold,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontFamily: 'Antonio',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontFamily: 'Antonio',
                              fontStyle: FontStyle.italic,
                            ),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Email',
                              labelText: 'Enter Email',
                              hintStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontFamily: 'Antonio',
                                fontStyle: FontStyle.italic,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontFamily: 'Antonio',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontFamily: 'Antonio',
                              decoration: TextDecoration.underline,
                            ),
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length != 10) {
                                return 'Phone number must be 10 digits';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Phone Number',
                              labelText: 'Enter Phone Number',
                              hintStyle: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontFamily: 'Antonio',
                                decoration: TextDecoration.underline,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontFamily: 'Antonio',
                                decoration: TextDecoration.underline,
                              ),
                              counterText: '',
                            ),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              _formKey.currentState?.validate();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text('Validate Form'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
