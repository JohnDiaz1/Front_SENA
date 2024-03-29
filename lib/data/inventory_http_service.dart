import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:front_sena/models/inventory_model.dart';
import 'package:front_sena/Utils/constants_app.dart';

class InventoryHttpService {
  final String _url = ConstantsApp.webURL + "inventory/";

  Future<List<Inventory>> getAllItems() async {
    var uri = Uri.parse(_url + "items");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return inventoryFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<Inventory> getItemById(String itemId) async {
    var uri = Uri.parse(_url + "getItemById/$itemId");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return Inventory.fromJson(json.decode(response.body));
    }else {
      throw("Error al obtener api");
    }
  }

  Future<bool> createItem(Inventory inventory) async {
    try {
      var uri = Uri.parse(_url + "addItem");
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: inventoryToJson(inventory));
      if (response.statusCode == 201) {
        return true; //"Se creo el item correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
        return false;
      }
    } catch (error) {
      print("Error en create item: $error");
      throw "Error inesperado";
    }
  }

  Future<bool> updateItem(Inventory item) async {
    try {
      var uri = Uri.parse(_url + "updateItem");
      var response = await http.put(uri,
          headers: {"Content-Type": "application/json"},
          body: inventoryToJson(item));
      if (response.statusCode == 200) {
        return true; //"Se actualizo la informacion del empleado correctamente";
      } else {
        return false; //"Error al actualizar informacion del empleado";
      }
    } catch (error) {
      throw "Error inesperado";
    }
  }

  Future<bool> deleteItemById(String itemId) async {
    try {
      var uri = Uri.parse(_url + "deleteItem/${itemId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return true; //"Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
        return false;
      }

    } catch(error) {
      print("Error en deleteItemById: $error");
      throw "Error inesperado";
    }
  }

}