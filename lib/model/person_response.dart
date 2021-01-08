import 'package:trailerfilm_app/model/person.dart';

class PersonResponse {
  final Person person;
  final String error;

  PersonResponse(this.person, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
  : person = Person.fromJson(json),
    error = "";
  PersonResponse.withError(String errorValue)
  : person = Person(null, null, "", "", "", "", "", ""),
    error = errorValue;
}