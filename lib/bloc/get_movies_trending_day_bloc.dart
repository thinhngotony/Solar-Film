import 'package:rxdart/rxdart.dart';
import 'package:trailerfilm_app/model/movie_response.dart';
import 'package:trailerfilm_app/repository/repository.dart';

class MoviesTrendingDayBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
  BehaviorSubject<MovieResponse>();

  getMoviesTredingDay() async {
    MovieResponse response = await _repository.getMoviesTrendingDay();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesTrendingDayBloc = MoviesTrendingDayBloc();