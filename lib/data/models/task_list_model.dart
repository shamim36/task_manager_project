import 'package:task_manager_project/data/models/task.dart';

class TaskListModel {
  String? status;
  List<Task>? taskList;

  TaskListModel({this.status, this.taskList});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <Task>[];
      json['data'].forEach((v) {
        taskList!.add(new Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> taskList = <String, dynamic>{};
    taskList['status'] = this.status;
    if (this.taskList != null) {
      taskList['data'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return taskList;
  }
}

