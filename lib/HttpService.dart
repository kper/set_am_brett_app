import 'dart:convert';

import 'package:set_am_brett_app/dto/DeveloperReallyMessedUpDto.dart';

import 'dto/EventDto.dart';
import 'package:http/http.dart';

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
        "https://www.setambrett.net/json-data/past-events-markup.json?first=$first&number=$number&year=$year",
        headers: requestHeaders);

    if (res.statusCode != 200) {
      print("error ${res.body}");
      return Future.error("Error response");
    }

    var body = json.decode(res.body);
    var messedup = DeveloperReallyMessedUpDto.fromJson(body);

    return Future.value(messedup.extractEvents());
  }

  Future<EventDto> getNextEvent() async {
    Map<String, String> requestHeaders = setupHeaders();
    Response res =
        await get("https://www.setambrett.net", headers: requestHeaders);

    if (res.statusCode != 200) {
      print("error ${res.body}");
      return Future.error("Error response");
    }

    var messedup = NextEvent(html: res.body);

    return Future.value(messedup.extractEvent());
  }
}
