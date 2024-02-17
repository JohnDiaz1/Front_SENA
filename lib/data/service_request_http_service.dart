import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/utils/constants_app.dart';

class ServiceRequestHttpService {
  final String _url = ConstantsApp.webURL + "serviceRequest/";

  Future<List<ServiceRequest>> getAllServiceRequest() async {
    var uri = Uri.parse(_url + "requests");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return serviceRequestFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }

  Future<ServiceRequest> getServiceRequestById(String serviceId) async {
    var uri = Uri.parse(_url + "getRequestById/$serviceId");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return ServiceRequest.fromJson(json.decode(response.body));
    }else {
      throw("Error al obtener api");
    }
  }

  Future<bool> updateServiceRequest(ServiceRequest serviceRequest) async {
    try {
      var uri = Uri.parse(_url + "updateRequest");
      var response = await http.put(uri,
          headers: {"Content-Type": "application/json"},
          body: serviceRequestToJson(serviceRequest));
      if (response.statusCode == 200) {
        return true; //"Se actualizo la informacion del empleado correctamente";
      } else {
        return false; //"Error al actualizar informacion del empleado";
      }
    } catch (error) {
      throw "Error inesperado";
    }
  }

  Future<bool> createServiceRequest(ServiceRequest serviceRequest) async {
    try {
      var uri = Uri.parse(_url + "addRequest");
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: serviceRequestToJson(serviceRequest)
      );

      if (response.statusCode == 201) {
        return true; //"Se creo el cliente correctamente";
      } else {
         print("Error en la solicitud: ${response.statusCode}, ${response.body}");
         return false;
      }
    } catch(error) {
      print("Error en createServiceRequest: $error");
      throw "Error inesperado";
    }
  }

  Future<bool> deleteServiceRequestById(String requestId) async {
    try {
      var uri = Uri.parse(_url + "deleteRequest/${requestId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return true; // "Se elimino correctamente";
      } else {
        print("Error en la solicitud: ${response.statusCode}, ${response.body}");
        return false;
      }

    } catch(error) {
      print("Error en deleteServiceRequestById: $error");
      throw "Error inesperado";
    }
  }

/* Future<List<Flags>> getFlagsByContinent() async {
    var uri = Uri.parse(_url + "subregion/Northem Europe");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      return flagsFromJson(response.body);
    }else{
      throw("Error al obtener api");
    }
  }*/
}

