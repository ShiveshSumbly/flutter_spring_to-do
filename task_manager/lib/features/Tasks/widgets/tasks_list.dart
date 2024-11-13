import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/Tasks/controller/task_controller.dart';
import 'package:task_manager/features/Tasks/view/create_task.dart';
import 'package:task_manager/features/Tasks/view/task_detail.dart';

class TasksList extends ConsumerWidget {
  const TasksList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("in the widget");
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ref.watch(tasksProvider).when(
            data: (tasks) {
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return GestureDetector(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.descr),
                      trailing: Text(task.dueDate.toLocal().toString()),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        TaskDetail.route(task),
                      );
                    },
                  );
                },
              );
            },
            error: (error, st) => ErrorWidget(error),
            loading: () => const CircularProgressIndicator(),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            TaskCreateView.route(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
