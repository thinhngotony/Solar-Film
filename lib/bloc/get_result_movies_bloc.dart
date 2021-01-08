import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trailerfilm_app/model/movie_response.dart';
import 'package:trailerfilm_app/repository/repository.dart';

class ResultMoviesBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
    BehaviorSubject<MovieResponse>();

  getResultMovies(String query) async {
    MovieResponse response = await _repository.getResultMovies(query);
    _subject.sink.add(response);
  }

  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final resultMoviesBloc = ResultMoviesBloc();