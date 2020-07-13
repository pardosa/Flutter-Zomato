import 'package:flutter/material.dart';
import 'package:restoapp/model/review.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewWidget extends StatelessWidget {
  final List<Review> listReview;

  const ReviewWidget({Key key, this.listReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    List<Widget> users = new List<Widget>();

    for (int x = 0; x < listReview.length; x++) {
      if (listReview[x].user != null) {
        var userCard = Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(0.2),
                  child: Image.network(listReview[x].user.profileImage),
                ),
                title: Text(listReview[x].user.name),
                subtitle: Text(listReview[x].user.foodieLevel),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 12, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SmoothStarRating(
                        allowHalfRating: true,
                        starCount: 5,
                        rating: double.parse(listReview[x].rating.toString()),
                        size: 20.0,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_border,
                        color: Colors.green,
                        borderColor: Colors.greenAccent,
                        spacing: 0.0),
                    Text(
                      listReview[x].ratingText,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      listReview[x].reviewTimeF,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5, left: 12, bottom: 10),
                  child: Wrap(
                      spacing: 5,
                      runSpacing: 5.0,
                      children: <Widget>[Text(listReview[x].reviewText)])),
            ],
          ),
        );

        users.add(userCard);
      }
    }

    return users.length > 0
        ? Container(
            width: sWidth,
            height: sHeight,
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: users,
              primary: false,
              shrinkWrap: true,
            ))
        : null;
  }
}
