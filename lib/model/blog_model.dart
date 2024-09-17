
class BlogModel {
  String? title;
  String? description;
  String? blogger;
  String? date;
  String? imageUrl;

  BlogModel({
    required this.title,
    required this.description,
    required this.blogger,
    required this.date,
    required this.imageUrl,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    blogger = json['blogger'];
    date = json['date'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['blogger'] = this.blogger;
    data['date'] = this.date;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}