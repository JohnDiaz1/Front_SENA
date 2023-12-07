// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

List<Client> clientFromJson(String str) => List<Client>.from(json.decode(str).map((x) => Client.fromJson(x)));

String clientToJson(List<Client> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Client {
  String clientId;
  String cedula;
  String name;
  String address;
  String phone;
  String email;

  Client({
    required this.clientId,
    required this.cedula,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    clientId: json["clientId"],
    cedula: json["cedula"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "cedula": cedula,
    "name": name,
    "address": address,
    "phone": phone,
    "email": email,
  };
}
