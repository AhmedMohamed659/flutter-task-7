import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class TasksTab extends StatefulWidget {
  final List<Task> tasks = [];

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  TextEditingController taskController = TextEditingController();
  String fullName = '';

  @override
  void initState() {
    super.initState();
    loadName();
  }

  void loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String first = prefs.getString('first_name') ?? '';
    String last = prefs.getString('last_name') ?? '';
    setState(() {
      fullName = '$first $last';
    });
  }

  void addTask() {
    if (taskController.text.trim().isEmpty) return;
    setState(() {
      widget.tasks.add(Task(name: taskController.text.trim()));
      taskController.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      widget.tasks.removeAt(index);
    });
  }

  void toggleComplete(int index) {
    setState(() {
      widget.tasks[index].isCompleted = !widget.tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: taskController,
                  decoration: InputDecoration(
                    hintText: 'Enter new task',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: addTask,
                child: Text('Add'),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: widget.tasks[index],
                  onDelete: () => deleteTask(index),
                  onToggleComplete: () => toggleComplete(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}