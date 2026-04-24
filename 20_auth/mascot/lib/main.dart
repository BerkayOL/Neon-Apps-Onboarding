import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mascot/app_routes.dart';
import 'package:mascot/firebase_options.dart';
import 'package:mascot/login_page.dart';
import 'package:mascot/logged.dart';
import 'package:mascot/register.dart';
import 'package:mascot/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banana Tree',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB67616)),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.login: (context) => const LoginPage(title: 'Banana Tree'),
        AppRoutes.register: (context) => const Register(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.verifyEmail) {
          final email = (settings.arguments as String?) ?? '';
          return MaterialPageRoute(
            builder: (context) => VerifyEmail(email: email),
          );
        }
        return null;
      },
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          final user = snapshot.data!;
          if (!user.emailVerified) {
            return VerifyEmail(email: user.email ?? '');
          }
          return const Logged();
        }
        return const LoginPage(title: 'Banana Tree');
      },
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isValidEmail(String email) {
    final trimmed = email.trim();
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(trimmed);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      final trimmedEmail = emailController.text.trim();
      final trimmedPassword = passwordController.text.trim();

      if (!_isValidEmail(trimmedEmail)) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'Geçerli bir e-mail adresi girin',
        );
      }
      if (trimmedPassword.isEmpty) {
        throw FirebaseAuthException(
          code: 'missing-password',
          message: 'Şifre alanı boş olamaz',
        );
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: trimmedPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Giriş sırasında beklenmeyen bir hata oldu'),
        ),
      );
    }
  }

  Future<void> sendResetEmail() async {
    try {
      final trimmedEmail = emailController.text.trim();
      if (!_isValidEmail(trimmedEmail)) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'Önce geçerli bir e-mail adresi girin',
        );
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: trimmedEmail);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? e.code)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Şifre sıfırlama sırasında hata oluştu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF1D3), Color(0xFFF6C667)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: login,
                        child: const Text('Login'),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final sonuc = await Navigator.push<Map<String, String>>(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
                        if (sonuc == null) return;
                        if (sonuc['durum'] == 'ok') {
                          emailController.text = sonuc['email'] ?? '';
                          passwordController.text = sonuc['password'] ?? '';
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Kayıt onaylandı, giriş yapılıyor'),
                            ),
                          );
                          await login();
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                sonuc['mesaj'] ?? 'Kayıt onaylanmadı',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Sign up with new account'),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: sendResetEmail,
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontFamily: 'Antonio',
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          fontSize: 28,
                          color: Colors.grey,
                        ),
                      ),
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
