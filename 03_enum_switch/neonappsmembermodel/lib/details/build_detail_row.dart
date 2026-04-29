import 'package:flutter/material.dart';

class BuildDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const BuildDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple.shade300),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
