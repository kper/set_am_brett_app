class GalleryDto {
  final int id;
  final String title;
  final String info; //Date
  final String img;

  GalleryDto({this.id, this.title, this.info, this.img});

  factory GalleryDto.fromJson(Map<String, dynamic> json) {
    return GalleryDto (
      id: json['id'] as int,
      title: json['title'] as String,
      info: json['info'] as String,
      img: json['img'] as String,
    );
  }
}