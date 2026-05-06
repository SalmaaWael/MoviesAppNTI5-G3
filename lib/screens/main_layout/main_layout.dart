import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager/colors_manager.dart';

import '../home_screen/home_screen.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Search Screen', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Watch List Screen', style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,

      body: screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  ColorsManager.background,
        selectedItemColor: ColorsManager.selectedIcons,
        unselectedItemColor: ColorsManager.unSelectedIcons,

        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,

        currentIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Watch list',
          ),
        ],
      ),
    );
  }
}