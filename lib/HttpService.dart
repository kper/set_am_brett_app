import 'dart:convert';

import 'package:set_am_brett_app/dto/EventDeveloperReallyMessedUpDto.dart';
import 'package:set_am_brett_app/dto/GalleriesDeveloperReallyMessedUpDto.dart';

import 'dto/EventDto.dart';
import 'package:http/http.dart';

import 'dto/GalleryDeveloperMessedUp.dart';
import 'dto/GalleryDto.dart';
import 'dto/NextEvent.dart';

class HttpService {
  Map<String, String> setupHeaders() {
    return {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      //'AUTHORIZATION': sessionToken
    };
  }

  Future<List<EventDto>> getEvents(int first, int number, int year) async {
    Map<String, String> requestHeaders = setupHeaders();
    Response res = await get(
        "https://setambrett.net/json-data/past-events-markup.json?first=$first&number=$number&year=$year",
        headers: requestHeaders);

    if (res.statusCode != 200) {
      print("error ${res.body}");
      return Future.error("Error response");
    }

    var body = json.decode(res.body);
    var messedup = EventDeveloperReallyMessedUpDto.fromJson(body);

    return Future.value(messedup.extractEvents());
  }

  Future<EventDto> getNextEvent() async {
    Map<String, String> requestHeaders = setupHeaders();
    Response res =
        await get("https://setambrett.net", headers: requestHeaders);

    if (res.statusCode != 200) {
      print("error ${res.body}");
      return Future.error("Error response");
    }

    var messedup = NextEvent(html: res.body);

    return Future.value(messedup.extractEvent());
  }

  Future<List<GalleryDto>> getGalleries(int first, int number, int year) async {
    Map<String, String> requestHeaders = setupHeaders();
    Response res = await get(
        "https://setambrett.net/json-data/gallery-markup.json?first=$first&number=$number&year=$year",
        headers: requestHeaders);

    if (res.statusCode != 200) {
      print("error ${res.body}");
      return Future.error("Error response");
    }

    var body = json.decode(res.body);
    var messedup = GalleriesDeveloperReallyMessedUpDto.fromJson(body);

    return Future.value(messedup.extractEvents());
  }

  /// Returns number of images in gallery
  Future<int> getNumberOfImages(int id) async {
    Map<String, String> requestHeaders = setupHeaders();
    Response res = await get("https://setambrett.net/gallery/$id",
        headers: requestHeaders);

    if (res.statusCode != 200) {
      print("error ${res.body}");
      return Future.error("Error response");
    }

    var messedup = GalleryDeveloperReallyMessedUpDto(html: res.body);

    return Future.value(messedup.extractNumberOfImages());
  }
}
