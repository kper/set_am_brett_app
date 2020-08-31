import 'package:html/parser.dart';

class GalleryDeveloperReallyMessedUpDto {
  final String html;

  GalleryDeveloperReallyMessedUpDto({this.html});

  int extractNumberOfImages() {
    var document = parse(this.html);

    return int.parse(document
        .getElementById("gallery-series-wrapper")
        .attributes["data-number-of-images"]);
  }
}
