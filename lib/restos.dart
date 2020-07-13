import 'package:flutter/material.dart';
import 'package:restoapp/pages/restopage.dart';
import 'package:restoapp/model/restaurant.dart';

class RestoWidget extends StatelessWidget {
  final List<Restaurant> listResto;

  const RestoWidget({Key key, this.listResto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    List<Widget> banners = new List<Widget>();

    for (int x = 0; x < listResto.length; x++) {
      // print(listResto[x].featuredImage);
      if (listResto[x].thumb != null) {
        var listRestos = Card(
            child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RestoPage(listResto[x])),
            );
          },
          child: ListTile(
            leading: Padding(
              padding: EdgeInsets.all(1.0),
              child: Image.network(listResto[x].thumb),
            ),
            title: Text(listResto[x].name),
            subtitle: Text(listResto[x].cuisines),
          ),
        ));

        banners.add(listRestos);
      }
    }

    return Container(
        width: sWidth, height: sHeight, child: ListView(children: banners));
  }
}
