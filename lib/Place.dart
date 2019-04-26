class Place {
  Place(this.id, this.placesId, this.adr);

  String id;
  String placesId;
  String adr;

  Place.fromJson(Map<String, dynamic> json)
      : id = json['p'],
        placesId = json['id'],
        adr = json['adr'];
}
