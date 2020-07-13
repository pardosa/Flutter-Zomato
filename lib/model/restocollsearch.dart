import 'package:restoapp/collection.dart';

class RestoSearchColls {
  final List<RestoCollection> collections;

  RestoSearchColls({this.collections});

  factory RestoSearchColls.fromJson(Map<String, dynamic> json) {
    List<RestoCollection> listRestoColls = [];

    for (Map i in json['collections']) {
      RestoCollection resto = RestoCollection.fromJson(i['collection']);
      listRestoColls.add(resto);
    }
    // print(listRestoColls);
    return RestoSearchColls(collections: listRestoColls);
  }
}
