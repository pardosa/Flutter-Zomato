import 'package:restoapp/model/review.dart';

class ReviewSearch {
  final int reviewsCount;
  final int reviewsStart;
  final int reviewsShown;
  final List<Review> reviews;

  ReviewSearch(
      {this.reviewsCount, this.reviewsStart, this.reviewsShown, this.reviews});

  factory ReviewSearch.fromJson(Map<String, dynamic> json) {
    List<Review> listReview = [];

    for (Map i in json['user_reviews']) {
      Review rev = Review.fromJson(i['review']);
      listReview.add(rev);
    }

    return ReviewSearch(
        reviewsCount: json['reviews_count'],
        reviewsStart: json['reviews_start'],
        reviewsShown: json['reviews_shown'],
        reviews: listReview);
  }
}
