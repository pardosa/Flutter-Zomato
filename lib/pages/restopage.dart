import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:restoapp/model/restaurant.dart';
import 'package:restoapp/model/reviewsearch.dart';
import 'package:restoapp/widgets/review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class RestoPage extends StatefulWidget {
  final Restaurant resto;

  RestoPage(this.resto);

  @override
  _RestoPageState createState() => _RestoPageState(resto);
}

Future<ReviewSearch> fetchRestaurantReviews([String id]) async {
  var url =
      'https://developers.zomato.com/api/v2.1/reviews?start=6&res_id=' + id;

  final response = await http
      .get(url, headers: {'user-key': 'API_KEY'});

  if (response.statusCode == 200) {
    // print(json.decode(response.body).toString());
    return ReviewSearch.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load restaurants');
  }
}

class _RestoPageState extends State<RestoPage> {
  final Restaurant resto;
  Future<ReviewSearch> futuReviewSearch;

  _RestoPageState(this.resto);

  @override
  void initState() {
    super.initState();
    futuReviewSearch = fetchRestaurantReviews(resto.id);
  }

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: sWidth,
                  height: sHeight * .32,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(2.0, 2.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0)
                            ]),
                      ),
                      ClipRRect(
                          child: Image.network(
                        resto.featuredImage,
                        fit: BoxFit.cover,
                      )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(1.0)),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black54])),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              resto.name,
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      resto.cuisines,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    )),
                                Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text(
                                      resto.location.locVerbose,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SmoothStarRating(
                                allowHalfRating: true,
                                starCount: 5,
                                rating:
                                    double.parse(resto.rating.aggregateRating),
                                size: 30.0,
                                filledIconData: Icons.star,
                                halfFilledIconData: Icons.star_border,
                                color: Colors.green,
                                borderColor: Colors.greenAccent,
                                spacing: 0.0),
                            Text(
                              resto.rating.aggregateRating,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                                ' (' +
                                    resto.rating.votes.toString() +
                                    ' Votes)',
                                style: TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic)),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Highlights :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5.0,
                                  children: highlights(resto.highlights),
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Average Cost :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5.0,
                                  children: <Widget>[
                                    Text(resto.currency +
                                        '. ' +
                                        resto.averageCostForTwo.toString() +
                                        ' for two people (approx.)')
                                  ],
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Open at :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5.0,
                                  children: <Widget>[Text(resto.timings)],
                                )
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Location :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                  spacing: 5,
                                  runSpacing: 5.0,
                                  children: <Widget>[
                                    Text(resto.location.street)
                                  ],
                                )
                              ],
                            )),
                      ],
                    )),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(top: 10),
                child: FutureBuilder<ReviewSearch>(
                  future: futuReviewSearch,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Reviews :',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            ReviewWidget(listReview: snapshot.data.reviews)
                          ]);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
//                  Padding(
//                      padding: EdgeInsets.only(top: 15, bottom: 15),
//                      child: Container(
//                        color: Colors.greenAccent,
//                        child: FlatButton(
//                          child: Text("Load More"),
//                          onPressed: () {},
//                        ),
//                      ))
            ]),
          )
        ]));
  }

  List<Widget> highlights(List items) {
    List<Widget> btns = [];
    for (var x = 0; x < items.length; x++) {
      if (items[x] != null)
        btns.add(Text(
          items[x],
          style: TextStyle(
            backgroundColor: Colors.tealAccent,
            fontStyle: FontStyle.italic,
          ),
        ));
    }
    return btns;
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('Restaurant Detail', style: TextStyle(fontSize: 18)),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
      ],
    );
  }
}
