import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:set_am_brett_app/dto/GalleryDto.dart';
import 'package:set_am_brett_app/subpages/GallerySubPage.dart';

import 'HttpService.dart';

class GalleriesPage extends StatefulWidget {
  @override
  _GalleriesPageState createState() => _GalleriesPageState();
}

class _GalleriesPageState extends State<GalleriesPage> {
  HttpService service = HttpService();
  bool isLoading = true;
  List<GalleryDto> galleries = List();

  _GalleriesPageState() {
    getGalleries();
  }

  Future<void> getGalleries() async {
    this.service.getGalleries(100, 100, 2020).then((value) {
      this.setState(() {
        galleries = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = ListView.builder(
        itemCount: galleries.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GallerySubPage(id: galleries[index].id)));
            },
            child: Card(
              child: Column(
                children: [
                  Image.network(
                    'https://setambrett.net' + galleries[index].img,
                    fit: BoxFit.fill,
                  ),
                  ListTile(
                    title: Text(galleries[index].title),
                    subtitle: Text(galleries[index].info),
                  )
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          );
        });

    return Container(
      child: isLoading ? Center(child: Text("Loading...")) : list,
    );
  }
}
