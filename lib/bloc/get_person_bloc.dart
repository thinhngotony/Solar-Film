import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:trailerfilm_app/model/person_response.dart';
import 'package:trailerfilm_app/repository/repository.dart';

class PersonBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
    BehaviorSubject<PersonResponse>();

  getPerson(int id) async {
    PersonResponse response = await _repository.getPerson(id);
    _subject.sink.add(response);
  }

  void drainStream(){ _subject.value = null; }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personDetailBloc = PersonBloc();