import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/Tasks/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';

class TaskDetail extends ConsumerStatefulWidget {
  static route(Task task) => MaterialPageRoute(
        builder: (context) => TaskDetail(task: task),
      );
  final Task task;
  const TaskDetail({super.key, required this.task});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskDetailState();
}

class _TaskDetailState extends ConsumerState<TaskDetail> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.descr);
    // Initialize with the task's current priority
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void saveChanges() {
    // print(descriptionController.text);
    Task newTask = widget.task.copyWith(descr: descriptionController.text);
    // print("in widget ${widget.task}");
    ref
        .read(taskControllerProvider.notifier)
        .updateTask(newTask, widget.task.id);
    toggleEditMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          _isEditing
              ? TextButton(
                  onPressed: saveChanges,
                  child: const Text("SAVE"),
                )
              : TextButton(
                  onPressed: toggleEditMode,
                  child: const Text("EDIT"),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isEditing
                ? TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Task Title",
                    ),
                  )
                : Text(
                    titleController.text,
                  ),
            const SizedBox(
              height: 20,
            ),
            _isEditing
                ? TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: "Task Description"),
                  )
                : Text(
                    descriptionController.text,
                  ),
          ],
        ),
      ),
    );
  }
}
