class Task {
  final String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'completed': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      name: map['name'],
      isCompleted: map['completed'],
    );
  }
}