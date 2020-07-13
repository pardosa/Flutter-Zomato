class RestoCollection {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final int resCount;

  RestoCollection(
      {this.id, this.title, this.description, this.imageUrl, this.resCount});

  factory RestoCollection.fromJson(Map<String, dynamic> json) {
    return RestoCollection(
        id: json['collection_id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['image_url'],
        resCount: json['res_count']);
  }
}
