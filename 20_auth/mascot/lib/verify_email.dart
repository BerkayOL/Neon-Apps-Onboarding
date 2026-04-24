import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascot/app_routes.dart';

class VerifyEmail extends StatefulWidget {
  final String email;
  const VerifyEmail({super.key, required this.email});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _sending = false;
  DateTime? _nextAllowedSendAt;

  bool _isValidEmail(String email) {
    final trimmed = email.trim();
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return emailRegex.hasMatch(trimmed);
  }

  String _humanizeError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Geçerli bir e-mail adresi girin';
      case 'too-many-requests':
        return 'Bu cihazdan çok fazla deneme yapıldı, lütfen daha sonra tekrar deneyin';
      case 'user-not-found':
        return 'Kullanıcı bulunamadı, tekrar kayıt olmayı deneyin';
      default:
        return e.message ?? e.code;
    }
  }

  Future<void> sendLink() async {
    try {
      final trimmedEmail = widget.email.trim();
      if (!_isValidEmail(trimmedEmail)) {
        throw FirebaseAuthException(
          code: 'invalid-email',
          message: 'Geçerli bir e-mail adresi bulunamadı',
        );
      }

      final now = DateTime.now();
      if (_nextAllowedSendAt != null && now.isBefore(_nextAllowedSendAt!)) {
        final seconds = _nextAllowedSendAt!.difference(now).inSeconds + 1;
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lütfen $seconds saniye sonra tekrar deneyin'),
          ),
        );
        return;
      }

      setState(() {
        _sending = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user == null ||
          (user.email?.toLowerCase() != trimmedEmail.toLowerCase())) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'Aktif kullanıcı bulunamadı',
        );
      }

      await user.sendEmailVerification();

      if (!mounted) return;
      _nextAllowedSendAt = DateTime.now().add(const Duration(seconds: 90));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Doğrulama e-postası gönderildi')),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_humanizeError(e))));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (!mounted) return;
      setState(() {
        _sending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Email',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Antonio',
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Antonio',
          fontStyle: FontStyle.italic,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please verify your email address',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontFamily: 'Antonio',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _sending ? null : sendLink,
              child: const Text(
                'Doğrulama E-postası Gönder',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Antonio',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              },
              child: const Text(
                'Have you registered before?',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Antonio',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
