import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:front_sena/models/client_model.dart';
import 'package:front_sena/utils/constants_app.dart';

class ClientHttpService {
  final String _url = ConstantsApp.webURL + "client/";

  Future<List<Client>> getAllClients() async {
    var uri = Uri.parse(_url + "clients");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return listClientFromJson(response.body);
    } else {
      throw ("Error al obtener api");
    }
  }

  Future<Client> getClientById(String clientId) async {
    var uri = Uri.parse(_url + "getClientById/$clientId");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      return Client.fromJson(json.decode(response.body));
    } else {
      throw ("Error al obtener api");
    }
  }

  Future<String> createClient(Client client) async {
    try {
      var uri = Uri.parse(_url + "addClient");
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: clientToJson(client));
      if (response.statusCode == 201) {
        return "Se creo el cliente correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }
    } catch (error) {
      print("Error en Create Cliente: $error");
      throw "Error inesperado";
    }
  }

  Future<String> updateClient(Client client) async {
    try {
      var uri = Uri.parse(_url + "updateClient");
      var response = await http.put(uri,
          headers: {"Content-Type": "application/json"},
          body: clientToJson(client));
      if (response.statusCode == 201) {
        return "Se creo el cliente correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }
    } catch (error) {
      print("Error en Create Cliente: $error");
      throw "Error inesperado";
    }
  }

  Future<String> deleteClientById(String clientId) async {
    try {
      var uri = Uri.parse(_url + "deleteClient/${clientId}");
      var response =
          await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return "Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }
    } catch (error) {
      print("Error en deleteClientById: $error");
      throw "Error inesperado";
    }
  }
}
