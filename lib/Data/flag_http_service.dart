import 'package:http/http.dart' as http;
import 'package:front_sena/models/flag_model.dart';

class FlagHttpService {
  final String _url = "https://restcountries.com/v3.1/";

      Future<List<Flags>> getFlagsByLanguage() async {
        var uri = Uri.parse(_url + "lang/spanish");
        var response = await http.get(uri);

        if(response.statusCode == 200){
          return flagsFromJson(response.body);
        }else{
          throw("Error al obtener api");
        }
      }

  Future<List<Flags>> getFlagsByContinent() async {
    var uri = Uri.parse(_url + "subregion/Northem Europe");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return flagsFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }


}