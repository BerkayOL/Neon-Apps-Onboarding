import 'package:adapty_flutter/adapty_flutter.dart';
import 'package:flutter/material.dart';
import 'package:adapty/main.dart';

class InAppScreen extends StatefulWidget {
  @override
  _InAppScreenState createState() => _InAppScreenState();
}

class _InAppScreenState extends State<InAppScreen> {
  bool _isLoading = false;

  Future<void> makePurchase(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final paywall = await Adapty().getPaywall(placementId: "premium_monthly");
      final products = await Adapty().getPaywallProducts(paywall: paywall);

      final product = products.firstWhere(
        (p) => p.vendorProductId == "premium_monthly",
      );

      await Adapty().makePurchase(product: product);
      final profile = await Adapty().getProfile();

      if (!context.mounted) return;

      if (profile.accessLevels['premium']?.isActive ?? false) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Payment Completed')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Adapty')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your payment has not been made')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Your payment has not been made')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> restorePurchases(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final profile = await Adapty().restorePurchases();

      if (!context.mounted) return;

      if (profile.accessLevels['premium']?.isActive ?? false) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Payment Completed')));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Adapty')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your payment has not been made')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Your payment has not been made')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFF6200EE),
        title: Text(
          'In-App Screen',
          style: TextStyle(
            fontFamily: 'Antonio',
            fontStyle: FontStyle.italic,
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6200EE)),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Per Month Price \$19.99',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Antonio',
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => makePurchase(context),
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(4),
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Antonio',
                        fontStyle: FontStyle.italic,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => restorePurchases(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Restore Purchases',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Antonio',
                        fontStyle: FontStyle.italic,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
