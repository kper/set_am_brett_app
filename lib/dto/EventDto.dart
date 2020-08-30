class EventDto {
  final String title;
  final String info; //Date
  final String img;

  EventDto({this.title, this.info, this.img});

  factory EventDto.fromJson(Map<String, dynamic> json) {
    return EventDto(
      title: json['title'] as String,
      info: json['info'] as String,
      img: json['img'] as String,
    );
  }
}