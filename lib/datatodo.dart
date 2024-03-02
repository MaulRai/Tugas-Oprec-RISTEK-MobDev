import 'package:hive/hive.dart';
part 'datatodo.g.dart';

@HiveType(typeId: 0)
class DataToDo extends HiveObject {
  @HiveField(0)
  String todos = "";

  @HiveField(1)
  DateTime? startDate;

  @HiveField(2)
  DateTime? endDate;

  @HiveField(3)
  bool isCompleted = false;

  @HiveField(4)
  bool isPriority = false;

  @HiveField(5)
  String desc = "";
  DataToDo(this.todos, this.startDate, this.endDate, this.isCompleted,
      this.isPriority, this.desc);
}
