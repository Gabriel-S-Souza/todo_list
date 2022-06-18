
class TasksBoardModel {
  late String title;

  List<String> tasks = [];

  TasksBoardModel();

  TasksBoardModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        tasks = json['tasks'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'tasks': tasks,
      };
}