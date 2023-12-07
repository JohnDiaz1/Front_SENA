import 'package:http/http.dart'as http;
import 'package:front_sena/models/inventory_model.dart';
import 'package:front_sena/Utils/constants_app.dart';

class InventoryHttpService {
  final String _url = ConstantsApp.webURL;

  Future<List<Inventory>> getAllItems() async {
    var uri = Uri.parse(_url + "items");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return inventoryFromJson(response.body);
    }else{
      throw("Error al obtener api");
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