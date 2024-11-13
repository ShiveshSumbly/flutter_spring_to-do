// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
// import 'dart:ffi';

// import 'package:flutter/foundation.dart';

import 'package:flutter/foundation.dart';
import 'package:task_manager/core/enums/priority_enum.dart';

@immutable
class Task {
  final int id;
  final String title;
  final String descr;
  final bool completed;
  final Priority priority;
  final DateTime createdDate;
  final DateTime dueDate;
  Task({
    required this.id,
    required this.title,
    required this.descr,
    required this.completed,
    required this.priority,
    required this.createdDate,
    required this.dueDate,
  });

  Task copyWith({
    int? id,
    String? title,
    String? descr,
    bool? completed,
    Priority? priority,
    DateTime? createdDate,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      descr: descr ?? this.descr,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      createdDate: createdDate ?? this.createdDate,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'title': title,
      'descr': descr,
      'completed': completed,
      'priority': priority.type,
      // 'createdDate': createdDate.millisecondsSinceEpoch,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      title: map['title'] as String,
      descr: map['descr'] as String,
      completed: map['completed'] as bool,
      priority: (map['priority'] as String).toPriorityEnum(),
      createdDate: DateTime.parse(map['createdDate'] as String),
      dueDate: DateTime.parse(map['dueDate'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, title: $title, descr: $descr, completed: $completed, priority: $priority, createdDate: $createdDate, dueDate: $dueDate)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.descr == descr &&
        other.completed == completed &&
        other.priority == priority &&
        other.createdDate == createdDate &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        descr.hashCode ^
        completed.hashCode ^
        priority.hashCode ^
        createdDate.hashCode ^
        dueDate.hashCode;
  }
}
