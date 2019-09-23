part of nearby;

class PlaceModel {

  final String id;
  final String title;
  final String detail;
  final List<String> image;
  final num lat;
  final num long;

  PlaceModel({
    this.id,
    this.title,
    this.detail,
    this.image,
    this.lat,
    this.long,
  });

  factory PlaceModel.fromMap(Map<String, dynamic> map) => PlaceModel(
    id: map["id"],
    title: map["title"] ?? map["name"],
    detail: map["detail"],
    image: map["image"],
    lat: map["lat"],
    long: map["long"],
  );

  factory PlaceModel.fromJson(String s) => PlaceModel.fromMap(json.decode(s));

  Map<String, dynamic> toMap() => <String, dynamic>{
    "id": this.id,
    "title": this.title,
    "detail": this.detail,
    "image": this.image,
    "lat": this.lat,
    "long": this.long,
  };

  String toJson() => json.encode(this.toMap());

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
      other is PlaceModel &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        title == other.title &&
        detail == other.detail &&
        image == other.image &&
        lat == other.lat &&
        long == other.long;

  @override
  int get hashCode =>
    id.hashCode ^
    title.hashCode ^
    detail.hashCode ^
    image.hashCode ^
    lat.hashCode ^
    long.hashCode;

  @override
  String toString() {
    return '$runtimeType{id: $id, title: $title, detail: $detail, image: $image, latitude: $lat, longitude: $long}';
  }

}