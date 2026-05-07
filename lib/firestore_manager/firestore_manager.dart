import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreManager {
  static final CollectionReference _watchlistCollection =
  FirebaseFirestore.instance.collection('watchlist');

  static Future<void> addToWatchlist(dynamic movie) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _watchlistCollection.doc(uid).collection('myMovies').doc(movie.id.toString()).set({
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'backdropPath': movie.backdropPath,
      'voteAverage': movie.voteAverage,
      'overview': movie.overview,
      'releaseDate': movie.releaseDate.toString(),
    });
  }

  static Future<void> removeFromWatchlist(int movieId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await _watchlistCollection.doc(uid).collection('myMovies').doc(movieId.toString()).delete();
  }

  static Stream<bool> isInWatchlist(int movieId) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return _watchlistCollection
        .doc(uid)
        .collection('myMovies')
        .doc(movieId.toString())
        .snapshots()
        .map((doc) => doc.exists);
  }

  static Stream<QuerySnapshot> getWatchlist() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return _watchlistCollection.doc(uid).collection('myMovies').snapshots();
  }
}