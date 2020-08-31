import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:set_am_brett_app/HttpService.dart';

class GallerySubPage extends StatefulWidget {
  final int id;

  GallerySubPage({this.id});

  @override
  _GallerySubPageState createState() => _GallerySubPageState(this.id);
}

class _GallerySubPageState extends State<GallerySubPage> {
  HttpService service = HttpService();
  int id;
  int numberOfImages = 0;
  bool isLoading = true;

  _GallerySubPageState(int id) {
    this.id = id;
    getNumberOfElements();
  }

  getNumberOfElements() {
    service.getNumberOfImages(id).then((value) {
      this.setState(() {
        numberOfImages = value;
        isLoading = false;
      });
    }).catchError((err) {
      print("$err");
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = ListView.builder(
        itemCount: numberOfImages,
        itemBuilder: (context, index) {
          final formatter = new NumberFormat("000");
          String formattedIndex = formatter.format(index + 1);
          return Card(
            child: Image.network(
              'https://setambrett.net/images/gallery/series-$id/full-scale/image-$id-$formattedIndex.jpg?v=1',
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          );
        });
      
    var body;

    if(isLoading) {
      body = Center(child: Text("Loading..."),);
    }
    else if (!isLoading && numberOfImages == 0) {
      body = Center(child: Text("Keine Bilder"),);
    }
    else {
      body = list;
    }

    return Scaffold(appBar: AppBar(title: Text("Galerie")), body: body);
  }
}
