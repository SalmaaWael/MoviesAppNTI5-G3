import 'package:flutter/material.dart';

import '../../assets_manager/assets_manager.dart';

class ListViewHorizontal extends StatelessWidget {
  const ListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 140,
                margin: const EdgeInsets.only(right: 16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 140,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image:AssetImage(AssetsManager.movie2),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      left: -15,
                      bottom: -25,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A2A2A),
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                            Shadow(
                              color: Colors.white24,
                              offset: Offset(-1, -1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

      ),
    );
  }
}
