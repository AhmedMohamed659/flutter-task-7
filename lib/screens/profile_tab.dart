import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../services/favorites_service.dart'; 

class ProfileTab extends StatefulWidget {
  final List<Task> tasks;

  const ProfileTab({super.key, required this.tasks});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  String firstName = '';
  String lastName = '';
  String email = '';
  String job = '';
  String address = '';
  String gender = '';

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    loadData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('first_name') ?? '';
      lastName = prefs.getString('last_name') ?? '';
      email = prefs.getString('email') ?? '';
      job = prefs.getString('job') ?? '';
      address = prefs.getString('address') ?? '';
      gender = prefs.getString('gender') ?? '';
    });
  }

  List<Task> get completedTasks =>
      widget.tasks.where((task) => task.isCompleted).toList();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile Info", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            infoRow("Name", "$firstName $lastName"),
            infoRow("Email", email),
            infoRow("Job", job),
            infoRow("Address", address),
            infoRow("Gender", gender),
            SizedBox(height: 20),
            Text("Completed Tasks", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            ...completedTasks.map((task) => ListTile(
              title: Text(task.name),
              leading: Icon(Icons.check, color: Colors.green),
            )),
            SizedBox(height: 30),

            Text(
              "Favourite Posts: ${FavoritesService.count()}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              },
              child: Text("Show Favourites"),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text("$label: $value"),
    );
  }
}