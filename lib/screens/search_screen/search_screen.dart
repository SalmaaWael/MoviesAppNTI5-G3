import 'package:flutter/material.dart';
import 'package:movies_app/api_manager/api_manager.dart';
import 'package:movies_app/core/colors_manager/colors_manager.dart';
import 'package:movies_app/models/movie_response.dart';
import '../movie_details/movie_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Search', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF3A3F47),
                hintText: "Search for a movie...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: query.isEmpty
                  ? _buildEmptyState()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/search_screen_image.png', width: 200),
          const SizedBox(height: 10),
          const Text("No movies found", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return FutureBuilder<MovieResponse>(
      future: ApiManager.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue));
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error fetching data", style: TextStyle(color: Colors.white)));
        }

        var movies = snapshot.data?.results ?? [];

        if (movies.isEmpty) {
          return const Center(child: Text("No movies match your search", style: TextStyle(color: Colors.white)));
        }

        return ListView.separated(
          itemCount: movies.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.grey, height: 30),
          itemBuilder: (context, index) {
            var movie = movies[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)),
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                      width: 100,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey, width: 100, height: 130, child: const Icon(Icons.error)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movie.title ?? "", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 20),
                            const SizedBox(width: 5),
                            Text(movie.voteAverage?.toStringAsFixed(1) ?? "0", style: const TextStyle(color: Colors.orange)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          (movie.releaseDate != null)
                              ? movie.releaseDate!.year.toString()
                              : "Unknown Year",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}