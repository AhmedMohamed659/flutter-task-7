import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/account_page.dart';
import 'screens/home_page.dart';
import 'screens/posts_page.dart';         
import 'screens/fav_posts_page.dart';    

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/account': (context) => AccountPage(),
        '/home': (context) => HomePage(),
        '/posts': (context) => const PostsPage(),        
        '/favorites': (context) => const FavPostsPage(), 
      },
    );
  }
}