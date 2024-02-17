import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/client_http_service.dart';
import 'package:front_sena/models/client_model.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> clientsModel = [];
  Client? clientModel;
  ClientHttpService clientHttpService = ClientHttpService();
  String responseString = "";
  bool response = false;

  Future<void> getAllClient() async {
    clientsModel = await clientHttpService.getAllClients();
    notifyListeners();
  }

  Future<void> getClientById(String clientId) async {
    clientModel = await clientHttpService.getClientById(clientId);
    notifyListeners();
  }

  Future<bool> createClient(Client client) async {
    response = await clientHttpService.createClient(client);
    notifyListeners();
    return response;
  }

  Future<bool> updateClient(Client client) async {
    response = await clientHttpService.updateClient(client);
    notifyListeners();
    return response;
  }

  Future<bool> deleteClientById(String clientId) async {
  response = await clientHttpService.deleteClientById(clientId);
  notifyListeners();
  return response;
  }

}