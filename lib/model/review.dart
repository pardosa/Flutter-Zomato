import 'package:restoapp/model/user.dart';

class Review {
  final int id;
  final int rating;
  final String reviewText;
  final String reviewTimeF;
  final String ratingText;
  final int likes;
  final User user;

  Review(
      {this.id,
      this.rating,
      this.reviewText,
      this.reviewTimeF,
      this.ratingText,
      this.likes,
      this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['id'],
        rating: json['rating'],
        reviewText: json['review_text'],
        reviewTimeF: json['review_time_friendly'],
        ratingText: json['rating_text'],
        likes: json['likes'],
        user: User.fromJson(json['user']));
  }
}
