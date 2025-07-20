import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String fullName;
  final Function(int) onItemTap;
  final VoidCallback onLogout;

  const CustomDrawer({
    required this.fullName,
    required this.onItemTap,
    required this.onLogout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              fullName,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text('Tasks'),
            onTap: () {
              onItemTap(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              onItemTap(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Posts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/posts');
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          ),
        ],
      ),
    );
  }
}