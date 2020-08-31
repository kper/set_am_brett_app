class GaleryDto {
  final String title;
  final String info; //Date
  final String img;

  GaleryDto({this.title, this.info, this.img});

  factory GaleryDto.fromJson(Map<String, dynamic> json) {
    return GaleryDto (
      title: json['title'] as String,
      info: json['info'] as String,
      img: json['img'] as String,
    );
  }
}