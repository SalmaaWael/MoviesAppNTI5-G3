import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager/colors_manager.dart';
import 'package:movies_app/screens/home_screen/popular_movies_grid.dart';

import 'bottom_navigation_bar.dart';
import 'list_view_horizontal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          backgroundColor: ColorsManager.background,
          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   ListViewHorizontal(),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                      child: Text("Popular",style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),

                      ),
                    ),
                    PopularMoviesGrid(),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15)),
                    CustomBottomNavBar(),
                  ],
                ),
              )) ,
        ),
      ),
    );
  }
}
