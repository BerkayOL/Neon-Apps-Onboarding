class GothamData {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final String companyName;
  final String companyCatchPhrase;

  GothamData({
    required this.name,
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.companyName,
    required this.companyCatchPhrase,
  });
  factory GothamData.fromJson(Map<String, dynamic> json) {
    return GothamData(
      id: json['id'].toString(),
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      street: json['address']['street'],
      suite: json['address']['suite'],
      city: json['address']['city'],
      zipcode: json['address']['zipcode'],
      companyName: json['company']['name'],
      companyCatchPhrase: json['company']['catchPhrase'],
    );
  }
}
