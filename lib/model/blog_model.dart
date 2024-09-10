
class MovieModel {
  String? movieName;
  String? movieOverview;
  String? movieReleaseDate;
  double? moviePopularity;
  String? moviePoster;
  int? movieId;

  MovieModel({
    required this.movieName,
    required this.movieOverview,
    required this.movieReleaseDate,
    required this.moviePopularity,
    required this.moviePoster,
    this.movieId,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    movieName = json['title'];
    movieOverview = json['overview'];
    movieReleaseDate = json['release_date'];
    moviePopularity = json['popularity'];
    moviePoster = json['poster_path'];
    movieId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.movieName;
    data['overview'] = this.movieOverview;
    data['release_date'] = this.movieReleaseDate;
    data['popularity'] = this.moviePopularity as double;
    data['poster_path'] = this.moviePoster;
    data['id'] = this.movieId as int;
    return data;
  }
}