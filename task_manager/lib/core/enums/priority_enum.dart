enum Priority {
  low('LOW'),
  medium('MEDIUM'),
  high('HIGH');

  final String type;
  const Priority(this.type);
}

extension ConvertPriority on String {
  Priority toPriorityEnum() {
    switch (this) {
      case 'LOW':
        return Priority.low;
      case 'MEDIUM':
        return Priority.medium;
      case 'HIGH':
        return Priority.high;
      default:
        return Priority.low;
    }
  }
}
