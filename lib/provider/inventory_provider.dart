import 'package:flutter/cupertino.dart';
import 'package:front_sena/Data/inventory_http_service.dart';
import 'package:front_sena/models/inventory_model.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> inventoryModel = [];
  InventoryHttpService inventoryHttpService = InventoryHttpService();
  String responseString = "";

  void getAllItems() async {
    inventoryModel = await inventoryHttpService.getAllItems();
    notifyListeners();
  }

  void createItem(Inventory inventory) async {
    responseString = await inventoryHttpService.createItem(inventory);
    notifyListeners();
  }

  void deleteItemById(String itemId) async {
    responseString = await inventoryHttpService.deleteItemById(itemId);
    notifyListeners();
  }

}