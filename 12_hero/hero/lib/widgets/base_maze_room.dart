import 'package:flutter/material.dart';

class BaseMazeRoom extends StatelessWidget {
  final String roomTitle;
  final VoidCallback onUp;
  final VoidCallback onDown;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  const BaseMazeRoom({
    super.key,
    required this.roomTitle,
    required this.onUp,
    required this.onDown,
    required this.onLeft,
    required this.onRight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(roomTitle),
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        titleTextStyle: const TextStyle(
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
            colors: [Colors.black, Color(0xFF1A1A2E)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: Hero(
                  tag: 'avatar',
                  child: Image(
                    image: AssetImage('assets/images/avatar.png'),
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildArrow(Icons.arrow_upward, onUp),
                    SizedBox(width: 24),
                    _buildArrow(Icons.arrow_downward, onDown),
                    SizedBox(width: 24),
                    _buildArrow(Icons.arrow_back, onLeft),
                    SizedBox(width: 24),
                    _buildArrow(Icons.arrow_forward, onRight),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArrow(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white38,
        border: Border.all(color: Colors.white24),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 28),
        onPressed: onPressed,
        padding: EdgeInsets.all(12),
      ),
    );
  }
}
