import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final String deviceType;
  final String imagePath;
  final bool isOn;
  final ValueChanged<bool> onToggle;

  const DeviceCard({
    super.key,
    required this.deviceName,
    required this.deviceType,
    required this.imagePath,
    required this.isOn,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOn ? Colors.greenAccent.shade100 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.settings, color: Colors.grey.shade700),
              onPressed: () {},
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: Image.asset(imagePath, fit: BoxFit.contain)),
              const SizedBox(height: 12),
              Text(
                deviceName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 4),
              Text(
                deviceType,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isOn ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isOn ? 'Açık' : 'Kapalı',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Switch(
                    value: isOn,
                    onChanged: onToggle,
                    activeThumbColor: Colors.green.shade700,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
