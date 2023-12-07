import 'package:flutter/cupertino.dart';
import 'package:front_sena/Data/client_http_service.dart';
import 'package:front_sena/models/client_model.dart';

class ClientProvider extends ChangeNotifier {
  List<Client> clientsModel = [];
  ClientHttpService clientHttpService = ClientHttpService();

  void getAllClient() async {
    clientsModel = await clientHttpService.getAllClients();
    notifyListeners();
  }
}