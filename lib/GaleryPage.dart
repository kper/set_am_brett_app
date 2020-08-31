import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:set_am_brett_app/dto/GaleryDto.dart';

import 'HttpService.dart';

class GaleryPage extends StatefulWidget {
  @override
  _GaleryPageState createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  HttpService service = HttpService();
  bool isLoading = true;
  List<GaleryDto> galeries = List();

  _GaleryPageState() {
    getGaleries();
  }

  Future<void> getGaleries() async {
    this.service.getGalaries(100, 100, 2020).then((value) {
      this.setState(() {
        galeries = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = ListView.builder(
        itemCount: galeries.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Image.network(
                  'https://setambrett.net' + galeries[index].img,
                  fit: BoxFit.fill,
                ),
                ListTile(
                  title: Text(galeries[index].title),
                  subtitle: Text(galeries[index].info),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
          );
        });

    return Container(
      child: isLoading ? Center(child: Text("Loading...")) : list,
    );
  }
}
