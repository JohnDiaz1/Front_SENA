import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/inventory_http_service.dart';
import 'package:front_sena/models/inventory_model.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> inventoryModel = [];
  Inventory? itemModel;
  InventoryHttpService inventoryHttpService = InventoryHttpService();
  String responseString = "";

  Future<void> getAllItems() async {
    inventoryModel = await inventoryHttpService.getAllItems();
    notifyListeners();
  }

  Future<void> getItemById(String itemId) async {
    itemModel = await inventoryHttpService.getItemById(itemId);
    notifyListeners();
  }

  void createItem(Inventory inventory) async {
    responseString = await inventoryHttpService.createItem(inventory);
    notifyListeners();
  }

  void updateItem(Inventory inventory) async {
    responseString = await inventoryHttpService.updateItem(inventory);
    notifyListeners();
  }

  void deleteItemById(String itemId) async {
    responseString = await inventoryHttpService.deleteItemById(itemId);
    notifyListeners();
  }

}