import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/enums/priority_enum.dart';
import 'package:task_manager/features/Tasks/controller/task_controller.dart';
import 'package:task_manager/model/task_model.dart';

class TaskCreateView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const TaskCreateView(),
      );
  const TaskCreateView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends ConsumerState<TaskCreateView> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _descr = '';
  Priority? _priority = Priority.low;
  DateTime? _dueDate;
  bool _completed = false;

  // Function to show Date Picker
  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
        print(picked);
      });
    }
  }

  void saveTask() {
    print(_dueDate);
    print("IN save of view");
    Task task = Task(
      id: 0,
      title: _title,
      descr: _descr,
      completed: _completed,
      priority: _priority ?? Priority.low,
      createdDate: DateTime.now(),
      dueDate: _dueDate ?? DateTime.now(),
    );
    ref.read(taskControllerProvider.notifier).createTask(task);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Title field
              TextFormField(
                decoration: InputDecoration(labelText: "Title"),
                onSaved: (value) => _title = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter a title"
                    : null,
              ),
              // Description field
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                onSaved: (value) => _descr = value ?? '',
                validator: (value) => value == null || value.isEmpty
                    ? "Please enter a description"
                    : null,
              ),
              // Priority dropdown
              DropdownButtonFormField<Priority>(
                decoration: InputDecoration(labelText: "Priority"),
                value: _priority,
                items: Priority.values.map((Priority priority) {
                  return DropdownMenuItem<Priority>(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Priority? newValue) {
                  setState(() {
                    _priority = newValue;
                  });
                },
              ),
              // Due date picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _dueDate == null
                        ? "No date chosen!"
                        : "Due Date: ${_dueDate!}",
                  ),
                  TextButton(
                    onPressed: () => _pickDueDate(context),
                    child: Text("Choose Due Date"),
                  ),
                ],
              ),
              // Completed checkbox
              CheckboxListTile(
                title: Text("Completed"),
                value: _completed,
                onChanged: (bool? newValue) {
                  setState(() {
                    _completed = newValue ?? false;
                  });
                },
              ),
              SizedBox(height: 20),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process the form data (e.g., save to database)
                    saveTask();
                  }
                },
                child: Text("Save Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
