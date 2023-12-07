import 'package:flutter/cupertino.dart';
import 'package:front_sena/Data/service_request_http_service.dart';
import 'package:front_sena/models/service_request_model.dart';

class ServiceRequestProvider extends ChangeNotifier {
  List<ServiceRequest> servicesModel = [];
  ServiceRequestHttpService serviceHttpService = ServiceRequestHttpService();
  String responseString = "";

  void getAllServiceRequests() async {
    servicesModel = await serviceHttpService.getAllServiceRequest();
    notifyListeners();
  }

  void createServiceRequest(ServiceRequest service) async {
    responseString = await serviceHttpService.createServiceRequest(service);
    notifyListeners();
  }

  void deleteServiceRequestById(String requestId) async {
    responseString = await serviceHttpService.deleteServiceRequestById(requestId);
    notifyListeners();
  }

}