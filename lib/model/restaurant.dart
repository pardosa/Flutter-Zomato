import 'package:restoapp/model/address.dart';
import 'package:restoapp/model/rating.dart';

class Restaurant {
  final String id;
  final String name;
  final String url;
  final String cuisines;
  final List<dynamic> highlights;
  final String featuredImage;
  final String thumb;
  final Address location;
  final String timings;
  final int averageCostForTwo;
  final String currency;
  final Rating rating;
  final int reviews;

  Restaurant(
      {this.id,
      this.name,
      this.url,
      this.cuisines,
      this.highlights,
      this.featuredImage,
      this.thumb,
      this.location,
      this.timings,
      this.averageCostForTwo,
      this.currency,
      this.rating,
      this.reviews});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    var addr = Address.fromJson(json['location']);
    return Restaurant(
        id: json['id'].toString(),
        name: json['name'],
        url: json['url'],
        cuisines: json['cuisines'],
        featuredImage: json['featured_image'],
        thumb: json['thumb'],
        highlights: json['highlights'],
        location: addr,
        timings: json['timings'],
        averageCostForTwo: json['average_cost_for_two'],
        currency: json['currency'],
        rating: Rating.fromJson(json['user_rating']),
        reviews: json['all_reviews_count']);
  }
}
