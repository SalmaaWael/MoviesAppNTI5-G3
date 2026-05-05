import 'package:flutter/material.dart';

import '../../core/assets_manager/assets_manager.dart';

class ListViewHorizontal extends StatelessWidget {
  const ListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
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
                          image: AssetImage(AssetsManager.movie2),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      left: -15,
                      bottom: -25,
                      child: Stack(
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 110,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = const Color(0xFF0296E5),
                            ),
                          ),
                          Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 110,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E2833),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}