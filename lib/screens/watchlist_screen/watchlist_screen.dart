import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager/colors_manager.dart';
import '../../firestore_manager/firestore_manager.dart';
import '../movie_details/movie_details.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Watchlist',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreManager.getWatchlist(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var movies = snapshot.data?.docs ?? [];

            if (movies.isEmpty) {
              return Center(
                child: Image.asset('assets/images/empty_wishlist.png'),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                var movieData = movies[index].data() as Map<String, dynamic>;
                var dummyMovie = _createDummyMovie(movieData);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: dummyMovie),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${movieData['posterPath']}',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  dynamic _createDummyMovie(Map<String, dynamic> data) {
    return _MovieProxy(data);
  }
}

class _MovieProxy {
  final Map<String, dynamic> _data;
  _MovieProxy(this._data);

  get id => _data['id'];
  get title => _data['title'];
  get posterPath => _data['posterPath'];
  get backdropPath => _data['backdropPath'];
  get voteAverage => _data['voteAverage'];
  get overview => _data['overview'];
  get releaseDate => DateTime.tryParse(_data['releaseDate'] ?? '');
}