class Rating {
  final String aggregateRating;
  final String ratingText;
  final String ratingColor;
  final int votes;

  Rating({
    this.aggregateRating,
    this.ratingText,
    this.ratingColor,
    this.votes,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
        aggregateRating: json['aggregate_rating'].toString(),
        ratingText: json['rating_text'],
        ratingColor: json['rating_color'],
        votes: json['votes']);
  }
}
