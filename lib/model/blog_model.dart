
class MovieModel {
  String? blogName;
  String? blogOverview;
  String? blogReleaseDate;
  double? blogPopularity;
  String? blogPoster;
  int? blogId;

  MovieModel({
    required this.blogName,
    required this.blogOverview,
    required this.blogReleaseDate,
    required this.blogPopularity,
    required this.blogPoster,
    this.blogId,
  });

  MovieModel.fromJson(Map<String, dynamic> json) {
    blogName = json['blogName'];
    blogOverview = json['overview'];
    blogReleaseDate = json['release_date'];
    blogPopularity = json['popularity'];
    blogPoster = json['poster_path'];
    blogId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogName'] = this.blogName;
    data['overview'] = this.blogOverview;
    data['release_date'] = this.blogReleaseDate;
    data['popularity'] = this.blogPopularity as double;
    data['poster_path'] = this.blogPoster;
    data['id'] = this.blogId as int;
    return data;
  }
}