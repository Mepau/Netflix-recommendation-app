class Show {
  final int id;
  final String title;
  final String img;
  final String vtype;
  final String synopsis;
  final double avgrating;
  final String poster;
  final double imdbrating;

  Show({
    required this.id,
    required this.title,
    required this.img,
    required this.vtype,
    required this.synopsis,
    required this.avgrating,
    required this.poster,
    required this.imdbrating,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json["id"],
      title: json["title"],
      img: json["img"],
      vtype: json["vtype"],
      synopsis: json["synopsis"],
      avgrating: json["avgrating"],
      poster: json["poster"],
      imdbrating: json["imdbrating"],
    );
  }
}
