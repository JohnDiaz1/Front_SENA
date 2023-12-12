import 'package:http/http.dart'as http;
import 'package:front_sena/models/inventory_model.dart';
import 'package:front_sena/Utils/constants_app.dart';

class InventoryHttpService {
  final String _url = ConstantsApp.webURL = "inventory/";

  Future<List<Inventory>> getAllItems() async {
    var uri = Uri.parse(_url + "items");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return inventoryFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<String> deleteItemById(String itemId) async {
    try {
      var uri = Uri.parse(_url + "deleteItem/${itemId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return "Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }

    } catch(error) {
      print("Error en deleteItemById: $error");
      throw "Error inesperado";
    }
  }

 /* Future<List<Flags>> getFlagsByContinent() async {
    var uri = Uri.parse(_url + "subregion/Northem Europe");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return flagsFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }*/

}