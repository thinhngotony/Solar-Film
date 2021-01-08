import 'package:dio/dio.dart';
import 'package:trailerfilm_app/config.dart';
import 'package:trailerfilm_app/model/movie_response.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

abstract class SearchMovies {
  SearchMovies();
  Future<MovieResponse> search(String query);
  Future<MovieResponse> searchMoviesById(int id);
  factory SearchMovies.getIntance() => _SearchMovies();
}

class _SearchMovies extends SearchMovies {
  static final _SearchMovies _singleton = new _SearchMovies._internal();
  factory _SearchMovies() => _singleton;
  _SearchMovies._internal();
  final Dio _dio = Dio();
  final String apiKey = "e7556e13b53e514462a8966edd54c782";
  static String mainUrl = "https://api.themoviedb.org/3";
  var searchMoviesUrl = "$mainUrl/search/movie";
  var searchMoviesIdUrl = "$mainUrl/movie";
  @override
  Future<MovieResponse> searchMoviesById(int id) async{
    var params = {
      "api_key": apiKey,
      "language": "vi",
    };
    try {
      Response response = await _dio.get(searchMoviesIdUrl + "/$id", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  @override
  Future<MovieResponse> search(String query) async{
    var params = {
      "api_key": apiKey,
      "language": "vi",
      "page": 1,
      "query": query,
    };
    try {
      Response response = await _dio.get(searchMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }
}