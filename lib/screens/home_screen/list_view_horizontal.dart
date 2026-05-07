import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager/colors_manager.dart';
import 'package:movies_app/screens/movie_details.dart';
import '../../models/movie_response.dart';

class ListViewHorizontal extends StatelessWidget {
  final Future<MovieResponse> apiFuture;

  const ListViewHorizontal({super.key, required this.apiFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieResponse>(
      future: apiFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 250,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          var moviesList = snapshot.data?.results ?? [];

          if (moviesList.isEmpty) return const SizedBox();

          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                var movie = moviesList[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                  child: Container(
                    width: 170,
                    margin: const EdgeInsets.only(right: 16),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30, bottom: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              width: 140,
                              height: 210,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: -10,
                          bottom: -35,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 130,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF242A32),
                              shadows: [
                                Shadow(
                                  color: ColorsManager.selectedIcons,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}