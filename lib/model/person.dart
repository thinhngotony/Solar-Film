class Person {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
  final String biography;
  final String birthday;
  final String placeOfBirth;

  Person(
    this.id,
    this.popularity,
    this.name,
    this.profileImg,
    this.known,
    this.biography,
    this.birthday,
    this.placeOfBirth
  );

  Person.fromJson(Map<String, dynamic> json)
  : id = json["id"],
    popularity = json["popularity"],
    name = json["name"],
    profileImg = json["profile_path"],
    biography = json["biography"],
    birthday = json["birthday"],
    placeOfBirth = json["place_of_birth"],
    known = json["known_for_department"];
}