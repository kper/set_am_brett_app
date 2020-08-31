import 'package:flutter/material.dart';
import 'package:set_am_brett_app/HttpService.dart';
import 'package:set_am_brett_app/dto/EventDto.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService service = HttpService();
  EventDto nextEvent;
  List<EventDto> oldEvents = List();
  bool isLoading = true;

  _HomePageState() {
    getNextEvent();
    getEvents();
  }

Future<void> getNextEvent() async {
    this.service.getNextEvent().then((value) {
      this.setState(() {
        nextEvent = value;
      });
    });
  }

  Future<void> getEvents() async {
    this.service.getEvents(100, 100, 2020).then((value) {
      this.setState(() {
        oldEvents = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = ListView.builder(
        itemCount: oldEvents.length,
        itemBuilder: (context, index) {

          if (index == 0) {
            //Hack

            return Card(
            child: Column(
              children: [
                Image.network(
                  'https://setambrett.net/images/special-background.jpg',
                  fit: BoxFit.fill,
                ),
                ListTile(
                  title: this.nextEvent != null? Text(nextEvent.title) : Text("Loading..."),
                  subtitle: this.nextEvent != null? Text(nextEvent.info) : Text("Loading..."),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            color: Color.fromRGBO(249,177, 33, 0.5),
          );
          }

          index -= 1;

          return Card(
            child: Column(
              children: [
                Image.network(
                  'https://setambrett.net' + oldEvents[index].img,
                  fit: BoxFit.fill,
                ),
                ListTile(
                  title: Text(oldEvents[index].title),
                  subtitle: Text(oldEvents[index].info),
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
      child: isLoading? Center(child: Text("Loading...")) : list,
    );
  }
}
