import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager/colors_manager.dart';
import '../home_screen/bottom_navigation_bar.dart';
import '../home_screen/home_screen.dart';
import '../watchlist_screen/watchlist_screen.dart';

class MainLayout extends StatefulWidget {
  static const String routeName = 'main_layout';

  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Search Screen', style: TextStyle(color: Colors.white, fontSize: 24))),
    const WatchlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      body: screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}