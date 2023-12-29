// To parse this JSON data, do
//
//     final inventory = inventoryFromJson(jsonString);

import 'dart:convert';

List<Inventory> inventoryFromJson(String str) => List<Inventory>.from(json.decode(str).map((x) => Inventory.fromJson(x)));

String listInventoryToJson(List<Inventory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String inventoryToJson(Inventory data) => json.encode(data.toJson());

class Inventory {
  String inventoryId;
  String name;
  String description;
  int stock;
  double precioCompra;
  double precioVenta;

  Inventory({
    required this.inventoryId,
    required this.name,
    required this.description,
    required this.stock,
    required this.precioCompra,
    required this.precioVenta,
  });

  Inventory.create({
    required this.name,
    required this.description,
    required this.stock,
    required this.precioCompra,
    required this.precioVenta,
}) : inventoryId = "";

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
    inventoryId: json["inventoryId"],
    name: json["name"],
    description: json["description"],
    stock: json["stock"],
    precioCompra: json["precioCompra"],
    precioVenta: json["precioVenta"],
  );

  Map<String, dynamic> toJson() => {
    "inventoryId": inventoryId,
    "name": name,
    "description": description,
    "stock": stock,
    "precioCompra": precioCompra,
    "precioVenta": precioVenta,
  };
}
