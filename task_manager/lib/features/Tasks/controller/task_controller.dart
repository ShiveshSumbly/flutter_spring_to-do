import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/api/task_api.dart';
import 'package:task_manager/model/task_model.dart';

final taskControllerProvider =
    StateNotifierProvider<TaskController, bool>((ref) {
  return TaskController(taskAPI: ref.watch(taskApiProvider));
});

final tasksProvider = FutureProvider((ref) {
  final taskState = ref.watch(taskControllerProvider);
  final taskController = ref.watch(taskControllerProvider.notifier);
  return taskController.getTasks();
});

class TaskController extends StateNotifier<bool> {
  final TaskAPI _taskAPI;
  TaskController({
    required TaskAPI taskAPI,
  })  : _taskAPI = taskAPI,
        super(false);

  Future<List<Task>> getTasks() async {
    print("in the controller");
    final taskList = await _taskAPI.getTasks();
    print("hello");
    return taskList;
  }

  void updateTask(Task newTask, int id) async {
    state = true;
    _taskAPI.updateTask(newTask, id);
    state = false;
  }

  void createTask(Task task) async {
    state = true;
    Task createdTask = await _taskAPI.createTask(task);
    print(createdTask);
    state = false;
  }
}
