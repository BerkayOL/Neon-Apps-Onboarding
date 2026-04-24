import 'package:hive_flutter/hive_flutter.dart'; // Importlar en üste
part 'task_model.g.dart'; // Part ifadesi importlardan sonra

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}
