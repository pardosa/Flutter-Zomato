import 'package:restoapp/model/restaurant.dart';

class RestoSearch {
  final int resultsFound;
  final int resultsStart;
  final int resultsShown;
  final List<Restaurant> restaurants;

  RestoSearch(
      {this.resultsFound,
      this.resultsStart,
      this.resultsShown,
      this.restaurants});

  factory RestoSearch.fromJson(Map<String, dynamic> json) {
    List<Restaurant> listResto = [];

    for (Map i in json['restaurants']) {
      Restaurant resto = Restaurant.fromJson(i['restaurant']);
      listResto.add(resto);
    }

    return RestoSearch(
        resultsFound: json['resultsFound'],
        resultsStart: json['resultsStart'],
        resultsShown: json['resultsShown'],
        restaurants: listResto);
  }
}
