import 'package:http/http.dart' as http;
import 'package:front_sena/models/client_model.dart';
import 'package:front_sena/Utils/constants_app.dart';

class ClientHttpService {
  final String _url = ConstantsApp.webURL;

  Future<List<Client>> getAllClients() async {
    var uri = Uri.parse(_url + "clients");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return clientFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<List<Client>> getClientById(String cedula) async {
    var uri = Uri.parse(_url + "client/$cedula");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return clientFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<String> deleteClientById(String clientId) async {
    try {
      var uri = Uri.parse(_url + "deleteClient/${clientId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return "Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }

    } catch(error) {
      print("Error en deleteClientById: $error");
      throw "Error inesperado";
    }
  }

}