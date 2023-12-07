import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/client_http_service.dart';
import 'package:front_sena/models/client_model.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> clientsModel = [];
  ClientHttpService clientHttpService = ClientHttpService();
  String responseString = "";

  void getAllClient() async {
    clientsModel = await clientHttpService.getAllClients();
    notifyListeners();
  }

  void deleteClientById(String clientId) async {
  responseString = await clientHttpService.deleteClientById(clientId);
  notifyListeners();
  }

}