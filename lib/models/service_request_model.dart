// To parse this JSON data, do
//
//     final serviceRequest = serviceRequestFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<ServiceRequest> serviceRequestFromJson(String str) => List<ServiceRequest>.from(json.decode(str).map((x) => ServiceRequest.fromJson(x)));

String serviceRequestListToJson(List<ServiceRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String serviceRequestToJson(ServiceRequest data) => json.encode(data.toJson());

enum ServiceRequestState { Activo, Pendiente, Finalizado, Cancelado }

class ServiceRequest {
  String requestId;
  String clientId;
  String description;
  DateTime requestDate;
  ServiceRequestState state;

  ServiceRequest({
    required this.requestId,
    required this.clientId,
    required this.description,
    required this.requestDate,
    required this.state,
  });

  ServiceRequest.create({
    required this.clientId,
    required this.description,
    required this.requestDate,
    required this.state,
  }) : requestId = "";

  factory ServiceRequest.fromJson(Map<String, dynamic> json) => ServiceRequest(
    requestId: json["requestId"],
    clientId: json["clientId"],
    description: json["description"],
    requestDate: _parseDateString(json["requestDate"]),
    state: _parseServiceRequestStateToString(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "description": description,
    "requestDate": requestDate.toIso8601String(),
    "state": _parseStringToServiceRequestState(state),
  };

  // Método para parsear la fecha
  static DateTime _parseDateString(String dateString) {
    try {
      return DateFormat("yyyy-MM-dd").parse(dateString);
    } catch (e) {
      // En caso de error al parsear la fecha, puedes manejarlo de acuerdo a tus necesidades
      print("Error al parsear la fecha: $e");
      return DateTime.now(); // Otra opción podría ser devolver la fecha actual
    }
  }

  String getFormattedDate() {
    return DateFormat("yyyy-MM-dd").format(requestDate);
  }

  static ServiceRequestState _parseServiceRequestStateToString(dynamic state) {
    switch (state) {
      case "Activo":
        return ServiceRequestState.Activo;
      case "Pendiente":
        return ServiceRequestState.Pendiente;
      case "Finalizado":
        return ServiceRequestState.Finalizado;
      case "Cancelado":
        return ServiceRequestState.Cancelado;
      default:
        throw Exception("Unknown ServiceRequestState: $state");
    }
  }

  static String _parseStringToServiceRequestState(dynamic state) {
    switch (state) {
      case ServiceRequestState.Activo:
        return "Activo";
      case  ServiceRequestState.Pendiente:
        return "Pendiente";
      case ServiceRequestState.Finalizado:
        return "Finalizado";
      case ServiceRequestState.Cancelado:
        return "Cancelado";
      default:
        throw Exception("Unknown ServiceRequestState: $state");
    }
  }

}
