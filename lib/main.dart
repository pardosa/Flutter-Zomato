import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restoapp/restos.dart';
import 'package:restoapp/restocols.dart';
import 'package:restoapp/model/restosearch.dart';
import 'package:restoapp/model/restocollsearch.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

Future<RestoSearch> fetchRestaurants([int id]) async {
  var url =
      'https://developers.zomato.com/api/v2.1/search?entity_id=74&entity_type=city&start=0&count=20&sort=rating';
  if (id != null) url = url + '&collection_id=' + id.toString();

  final response = await http
      .get(url, headers: {'user-key': 'API-KEY'});

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print(json.decode(response.body).toString());
    return RestoSearch.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load restaurants');
  }
}

Future<RestoSearchColls> fetchRestoCollections() async {
  var url = 'https://developers.zomato.com/api/v2.1/collections?city_id=74';

  final response = await http
      .get(url, headers: {'user-key': 'API_KEY'});

  if (response.statusCode == 200) {
    return RestoSearchColls.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load restaurant collections');
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  Future<RestoSearch> futuRestoSearch;
  Future<RestoSearchColls> futuRestoColls;
  String listTitle = 'Top Restaurants';

  @override
  void initState() {
    super.initState();
    futuRestoSearch = fetchRestaurants();
    futuRestoColls = fetchRestoCollections();
  }

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;
    var sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        height: sHeight,
        width: sWidth,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<RestoSearchColls>(
                future: futuRestoColls,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RestoCollWidget(
                      listRestoColl: snapshot.data.collections,
                      onPressCallback: (int id, String title) {
                        setState(() {
                          listTitle = title;
                          futuRestoSearch = fetchRestaurants(id);
                        });
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  listTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                child: FutureBuilder<RestoSearch>(
                  future: futuRestoSearch,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return RestoWidget(listResto: snapshot.data.restaurants);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Text('Restaurants', style: TextStyle(fontSize: 25)),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
      ],
    );
  }
}
