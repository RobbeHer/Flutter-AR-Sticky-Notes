import './metadata.dart';

class Note {
  String id;
  int rating;
  Metadata metadata;

  Note(
      {this.id,
      this.rating,
      this.metadata});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }
    return data;
  }
}
