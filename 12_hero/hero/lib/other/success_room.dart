import 'package:flutter/material.dart';

class SuccessRoom extends StatelessWidget {
  const SuccessRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Room'),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontFamily: 'Antonio',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A1A0A), Colors.black],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events_rounded,
                size: 80,
                color: Color(0xFF00FF88),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF00FF88).withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Congratulations, you did it!',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Antonio',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF00FF88),
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
