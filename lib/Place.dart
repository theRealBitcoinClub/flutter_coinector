class Place {
  Place(this.id, this.placesId);

  String id;
  String placesId;

  Place.fromJson(Map<String, dynamic> json)
      : id = json['p'],
        placesId = json['placesId'];
}
