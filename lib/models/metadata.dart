class Metadata {
  String id;
  String imgId;
  String title;
  String content;

  Metadata({this.title, this.content});

  Metadata.fromJson(Map<String, dynamic> json) {
    imgId = json['imgId'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgId'] = this.imgId;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
