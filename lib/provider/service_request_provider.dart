import 'package:flutter/cupertino.dart';
import 'package:front_sena/data/service_request_http_service.dart';
import 'package:front_sena/models/service_request_model.dart';

class ServiceRequestProvider extends ChangeNotifier {
  List<ServiceRequest> servicesModel = [];
  ServiceRequest? serviceModel;
  ServiceRequestHttpService serviceHttpService = ServiceRequestHttpService();
  String responseString = "";
  bool response = false;

  Future<void> getAllServiceRequests() async {
    servicesModel = await serviceHttpService.getAllServiceRequest();
    notifyListeners();
  }

  Future<void> getServiceRequestById(String serviceId) async {
    serviceModel = await serviceHttpService.getServiceRequestById(serviceId);
    notifyListeners();
  }

  Future<bool> createServiceRequest(ServiceRequest service) async {
    response = await serviceHttpService.createServiceRequest(service);
    notifyListeners();
    return response;
  }

  Future<bool> updateServiceRequest(ServiceRequest serviceRequest) async {
    response = await serviceHttpService.updateServiceRequest(serviceRequest);
    notifyListeners();
    return response;
  }

  Future<bool> deleteServiceRequestById(String requestId) async {
    response = await serviceHttpService.deleteServiceRequestById(requestId);
    notifyListeners();
    return response;
  }

}