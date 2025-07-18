import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tasks_tab.dart';
import 'profile_tab.dart';
import 'home_tab.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  TasksTab tasksTab = TasksTab();
  String fullName = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String first = prefs.getString('first_name') ?? '';
    String last = prefs.getString('last_name') ?? '';
    setState(() {
      fullName = '$first $last';
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: CustomDrawer(
        fullName: fullName,
        onItemTap: (index) {
          setState(() => selectedIndex = index);
        },
        onLogout: logout,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomeTab(),
          tasksTab,
          ProfileTab(tasks: tasksTab.tasks),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}