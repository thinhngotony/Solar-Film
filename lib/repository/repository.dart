import 'package:dio/dio.dart';
import 'package:trailerfilm_app/main.dart';
import 'package:trailerfilm_app/model/cast_response.dart';
import 'package:trailerfilm_app/model/movie_detail_response.dart';
import 'package:trailerfilm_app/model/person_response.dart';
import 'dart:async';
import 'package:trailerfilm_app/model/persons_response.dart';
import 'package:trailerfilm_app/model/genre_response.dart';
import 'package:trailerfilm_app/model/movie_response.dart';
import 'package:trailerfilm_app/model/video_response.dart';

class MovieRepository {
  // Enter your api key
  final String apiKey = "e7556e13b53e514462a8966edd54c782";
  // Enter your main url
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = "$mainUrl/genre/movie/list";
  var getPersonsUrl = "$mainUrl/trending/person/week";
  var getPersonUrl = "$mainUrl/person";
  var movieUrl = "$mainUrl/movie";
  var searchMoviesUrl = "$mainUrl/search/movie";
  var getMoviesTrendingDayUrl = "$mainUrl/trending/movie/day";
  var getMoviesTrendingWeekUrl = "$mainUrl/trending/movie/week";

  Future<MovieResponse> getMovies() async {
    var params = {
      "api_key": apiKey,
      "language": "vi",
      "page": 1
    };
    try {
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMoviesTrendingDay() async {
    var params = {
      "api_key": apiKey,
      "language": "vi",
    };
    try {
      Response response = await _dio.get(getMoviesTrendingDayUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMoviesTrendingWeek() async {
    var params = {
      "api_key": apiKey,
      "language": "vi",
    };
    try {
      Response response = await _dio.get(getMoviesTrendingWeekUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "vi", "page": 1};
    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "vi"};
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenreResponse.withError("$error");
    }
  }


  Future<PersonsResponse> getPersons() async {
    var params = {"api_key": apiKey, "language": "vi",};
    try {
      Response response = await _dio.get(getPersonsUrl, queryParameters: params);
      return PersonsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonsResponse.withError("$error");
    }
  }

  Future<PersonResponse> getPerson(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "vi",
    };
    try {
      Response response = await _dio.get(getPersonUrl + "/$id", queryParameters: params);
      return PersonResponse.fromJson(response.data);
    }
    catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PersonResponse.withError("$error");
    }
  }

  Future<MovieResponse> getMovieByGenre(int id) async {
    var params = {"api_key": apiKey, "language": "vi", "page": 1, "with_genres": id};
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieDetailResponse> getMovieDetail(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "vi"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieDetailResponse.withError("$error");
    }
  }

  Future<VideoResponse> getMovieVideos(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "vi"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return VideoResponse.withError("$error");
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "vi"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/similar", queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<CastResponse> getCasts(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "vi"
    };
    try {
      Response response = await _dio.get(movieUrl + "/$id" + "/credits", queryParameters: params);
      return CastResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CastResponse.withError("$error");
    }
  }
  Future<MovieResponse> getResultMovies(String query) async {
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