import 'package:html/parser.dart';
import 'GalleryDto.dart';

class GalleriesDeveloperReallyMessedUpDto {
  final String title;
  final String html;

  GalleriesDeveloperReallyMessedUpDto({this.title, this.html});

  factory GalleriesDeveloperReallyMessedUpDto.fromJson(Map<String, dynamic> json) {
    return GalleriesDeveloperReallyMessedUpDto(
      title: json['title'] as String,
      html: json['html'] as String,
    );
  }

  List<GalleryDto> extractEvents() {
    var document = parse(this.html);

    var ids = document
        .getElementsByTagName("a")
        .map((e) => int.parse(e.attributes["data-item-id"]))
        .toList();

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

    List<GalleryDto> events = List();

    for (var i = 0; i < titles.length; i++) {
      events.add(GalleryDto(
          id: ids[i], title: titles[i], img: images[i], info: info[i]));
    }

    return events;
  }
}
