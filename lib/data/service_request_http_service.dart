import 'package:http/http.dart' as http;
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/Utils/constants_app.dart';

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

  Future<String> createServiceRequest(ServiceRequest serviceRequest) async {
    try {
      var uri = Uri.parse(_url + "addRequest");
      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: serviceRequestToJson(serviceRequest)
      );

      if (response.statusCode == 201) {
        return "Se creo el cliente correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
      }
    } catch(error) {
      print("Error en createServiceRequest: $error");
      throw "Error inesperado";
    }
  }

  Future<String> deleteServiceRequestById(String requestId) async {
    try {
      var uri = Uri.parse(_url + "deleteRequest/${requestId}");
      var response = await http.delete(uri, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 204) {
        return "Se elimino correctamente";
      } else {
        throw "Error en la solicitud: ${response.statusCode}, ${response.body}";
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

