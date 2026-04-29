class DeviceModel {
  final String name;
  final String type;
  final String imagePath;
  bool isOn;

  DeviceModel({
    required this.name,
    required this.type,
    required this.imagePath,
    this.isOn = false,
  });
}
