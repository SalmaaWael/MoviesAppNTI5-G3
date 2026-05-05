import 'package:flutter/material.dart';

import '../../api_manager/api_manager.dart';
import '../../models/movie_response.dart';

class PopularMoviesGrid extends StatelessWidget {
  const PopularMoviesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieResponse>(
      future: ApiManager.getPopularMovies(),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        if (snapshot.hasData) {
          var moviesList = snapshot.data?.results ?? [];

          if (moviesList.isEmpty) {
            return const Center(
              child: Text('There is no movies now', style: TextStyle(color: Colors.white)),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: moviesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              var movie = moviesList[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}