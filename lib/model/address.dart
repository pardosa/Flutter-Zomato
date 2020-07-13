class Address {
  final String street;
  final String locality;
  final String city;
  final int cityId;
  final String lat;
  final String long;
  final String zipcode;
  final int countryId;
  final String locVerbose;

  Address(
      {this.street,
      this.locality,
      this.city,
      this.cityId,
      this.lat,
      this.long,
      this.zipcode,
      this.countryId,
      this.locVerbose});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['address'],
      locality: json['locality'],
      city: json['city'],
      cityId: json['city_id'],
      lat: json['latitude'],
      long: json['longitude'],
      zipcode: json['zipcode'],
      countryId: json['country_id'],
      locVerbose: json['locality_verbose'],
    );
  }
}
