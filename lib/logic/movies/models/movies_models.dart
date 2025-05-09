class Movie {
  final String title;
  final String director;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String writer;
  final String actors;
  final String plot;
  final List<String> images;

  Movie({
    required this.title,
    required this.director,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.images
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      director: json['Director'],
      rated: json['Rated'],
      released: json['Released'],
      runtime: json['Runtime'],
      genre: json['Genre'],
      writer: json['Writer'],
      actors: json['Actors'],
      plot: json['Plot'],
      images : List<String>.from(json['Images']),
    );
  }
}