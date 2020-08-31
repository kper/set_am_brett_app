import 'package:html/parser.dart';

import 'EventDto.dart';
import 'GaleryDto.dart';

class GaleryDeveloperReallyMessedUpDto {
  final String title;
  final String html;

  GaleryDeveloperReallyMessedUpDto({this.title, this.html});

  factory GaleryDeveloperReallyMessedUpDto.fromJson(Map<String, dynamic> json) {
    return GaleryDeveloperReallyMessedUpDto(
      title: json['title'] as String,
      html: json['html'] as String,
    );
  }

  List<GaleryDto> extractEvents() {
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

    List<GaleryDto> events = List();

    for (var i = 0; i < titles.length; i++) {
      events.add(GaleryDto(title: titles[i], img: images[i], info: info[i]));
    }

    return events;
  }
}
