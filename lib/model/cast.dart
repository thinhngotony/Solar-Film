class Cast {
  final int id;
  final String character;
  final String name;
  final String img;
  final String knownForDepartment;

  Cast(
    this.id,
    this.character,
    this.name,
    this.img,
    this.knownForDepartment
  );

  Cast.fromJson(Map<String, dynamic> json)
  : id = json["cast_id"],
    character = json["character"],
    name = json["name"],
    knownForDepartment = json["known_for_department"],
    img = json["profile_path"];
}