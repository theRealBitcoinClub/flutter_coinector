class Place {
  Place(this.id, this.placesId, this.shareId, this.adr);

  String id;
  String placesId;
  String shareId;
  String adr;

  Place.fromJson(Map<String, dynamic> json)
      : id = json['p'],
        placesId = json['placesId'],
        shareId = json['shareId'],
        adr = json['adr'];
}
