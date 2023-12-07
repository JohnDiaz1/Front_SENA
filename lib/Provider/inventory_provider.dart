import 'package:flutter/cupertino.dart';
import 'package:front_sena/Data/inventory_http_service.dart';
import 'package:front_sena/models/inventory_model.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> inventoryModel = [];
  InventoryHttpService inventoryHttpService = InventoryHttpService();

  void getAllItems() async {
    inventoryModel = await inventoryHttpService.getAllItems();
    notifyListeners();
  }

}