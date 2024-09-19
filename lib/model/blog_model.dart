
class BlogModel {
  String? title;
  String? description;
  String? blogger;
  String? date;
  String? imageUrl;
  String? id;

  BlogModel({
    this.title,
    this.description,
    this.blogger,
    this.date,
    this.imageUrl,
    this.id,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    blogger = json['blogger'];
    date = json['date'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['blogger'] = this.blogger;
    data['date'] = this.date;
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}