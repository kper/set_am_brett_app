import 'package:set_am_brett_app/dto/EventDto.dart';
import 'package:html/parser.dart';

class NextEvent {
  final String html;

  NextEvent({this.html});

  EventDto extractEvent() {
    var document = parse(this.html);

    var date = document
        .getElementsByClassName("h1--hero")
        .map((e) => e.innerHtml)
        .toList();

    var title = document
        .getElementsByClassName("hero-special__heading")
        .map((e) => e.innerHtml)
        .toList();

    return EventDto(title: title[0], info: date[0], img: "hard coded");
  }
}
