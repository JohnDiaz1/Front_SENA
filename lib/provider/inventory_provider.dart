import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/inventory_http_service.dart';
import 'package:front_sena/models/inventory_model.dart';

class InventoryProvider extends ChangeNotifier {
  List<Inventory> inventoryModel = [];
  Inventory? itemModel;
  InventoryHttpService inventoryHttpService = InventoryHttpService();
  String responseString = "";
  bool response = false;

  Future<void> getAllItems() async {
    inventoryModel = await inventoryHttpService.getAllItems();
    notifyListeners();
  }

  Future<void> getItemById(String itemId) async {
    itemModel = await inventoryHttpService.getItemById(itemId);
    notifyListeners();
  }

  Future<bool> createItem(Inventory inventory) async {
    response = await inventoryHttpService.createItem(inventory);
    notifyListeners();
    return response;
  }

  Future<bool> updateItem(Inventory inventory) async {
    response = await inventoryHttpService.updateItem(inventory);
    notifyListeners();
    return response;
  }

  Future<bool> deleteItemById(String itemId) async {
    response = await inventoryHttpService.deleteItemById(itemId);
    notifyListeners();
    return response;
  }

}