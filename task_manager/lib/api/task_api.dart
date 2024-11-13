import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:http/http.dart' as http;

final taskApiProvider = Provider((ref) {
  return TaskAPI();
});

abstract class ITaskAPI {
  Future<List<Task>> getTasks();
  void updateTask(Task newTask, int id);
  Future<Task> createTask(Task task);
}

class TaskAPI implements ITaskAPI {
  @override
  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('http://localhost:8080/tasks'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return data.map<Task>((e) => Task.fromMap(e)).toList();
    } else {
      throw Exception("Failed to load task");
    }
  }

  @override
  void updateTask(Task newTask, int id) async {
    final headers = {
      'Content-Type': 'application/json', // Ensure JSON content type
    };

    final requestBody = jsonEncode(newTask.toMap());

    final response = await http.put(Uri.parse('http://localhost:8080/task/$id'),
        body: requestBody, headers: headers);

    if (response.statusCode != 201) {
      throw Exception("Failed to update task");
    }
  }

  @override
  Future<Task> createTask(Task task) async {
    final headers = {
      'Content-Type': 'application/json', // Ensure JSON content type
    };
    final requestBody = jsonEncode(task.toMap());
    final response = await http.post(Uri.parse('http://localhost:8080/task'),
        body: requestBody, headers: headers);

    if (response.statusCode != 201) {
      throw Exception("Failed to update task");
    } else {
      print(response.body);
      return task;
    }
  }
}
