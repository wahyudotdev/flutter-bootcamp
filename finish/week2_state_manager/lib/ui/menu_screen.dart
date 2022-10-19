import 'package:flutter/material.dart';
import 'package:week2_state_manager/ui/home/home_screen.dart';
import 'package:week2_state_manager/ui/profile/profile_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentScreen = 0;

  final _screens = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  final _navBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentScreen,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: _currentScreen,
        onTap: (index) => setState(() => _currentScreen = index),
      ),
    );
  }
}
