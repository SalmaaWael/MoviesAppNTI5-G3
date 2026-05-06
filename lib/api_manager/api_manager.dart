import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_response.dart';

class ApiManager {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '9d7f94be913eddf2db40e317d2f12f36';
  static Future<MovieResponse> getPopularMovies() async {
    var url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        return MovieResponse.fromJson(json);
      } else {
        throw Exception('Failed to load movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
  static Future<MovieResponse> getUpcomingMovies() async {
    var url = Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieResponse.fromJson(json);
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  static Future<MovieResponse> getTopRatedMovies() async {
    var url = Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieResponse.fromJson(json);
      } else {
        throw Exception('Failed to load top rated movies');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}