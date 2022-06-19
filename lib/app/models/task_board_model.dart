
class TasksBoardModel {
  late String title;
  late int position;

  Map<int, String> tasks = {};

  TasksBoardModel();

  TasksBoardModel.fromJson(Map<String, dynamic> json) {
    Map<int, String> _tasks = {};

    (json['tasks'] as Map).forEach((key, value) {
      final int position = int.parse(key);
      _tasks[position] = value;
    });

    title = json['title'];
    position = json['position'];
    tasks = _tasks;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'tasks': tasks,
      };
}