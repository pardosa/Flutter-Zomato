import 'package:flutter/material.dart';
import 'package:restoapp/collection.dart';

class RestoCollWidget extends StatelessWidget {
  final List<RestoCollection> listRestoColl;
  final void Function(int, String) onPressCallback;

  const RestoCollWidget({Key key, this.listRestoColl, this.onPressCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    PageController pageController = PageController(initialPage: 1);

    List<Widget> banners = new List<Widget>();

    for (int x = 0; x < listRestoColl.length; x++) {
      // print(listResto[x].featuredImage);
      if (listRestoColl[x].imageUrl != null) {
        var featuredImage = Padding(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                onPressCallback(listRestoColl[x].id, listRestoColl[x].title);
              },
              child: Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(2.0, 2.0),
                                blurRadius: 5.0,
                                spreadRadius: 1.0)
                          ]),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        child: Image.network(
                          listRestoColl[x].imageUrl,
                          fit: BoxFit.fitWidth,
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black54])),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            listRestoColl[x].title,
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Text(
                            listRestoColl[x].description,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));

        banners.add(featuredImage);
      }
    }

    return Container(
      width: sWidth,
      height: sHeight * 1 / 3,
      child: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
