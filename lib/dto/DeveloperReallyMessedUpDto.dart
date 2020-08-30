import 'package:html/parser.dart';

import 'EventDto.dart';

class DeveloperReallyMessedUpDto {
  final String title;
  final String html;

  DeveloperReallyMessedUpDto({this.title, this.html});

  factory DeveloperReallyMessedUpDto.fromJson(Map<String, dynamic> json) {
    return DeveloperReallyMessedUpDto(
      title: json['title'] as String,
      html: json['html'] as String,
    );
  }

  List<EventDto> extractEvents() {
    var document = parse(this.html);

    var titles = document
        .getElementsByClassName("teaser__title")
        .map((e) => e.innerHtml)
        .toList();

    var images = document
        .getElementsByClassName("teaser__image")
        .map((e) => e.attributes["src"])
        .toList();

    var info = document
        .getElementsByClassName("teaser__info-line")
        .map((e) => e.innerHtml)
        .toList();

    List<EventDto> events = List();

    for (var i = 0; i < titles.length; i++) {
      events.add(EventDto(title: titles[i], img: images[i], info: info[i]));
    }

    return events;
  }
}
