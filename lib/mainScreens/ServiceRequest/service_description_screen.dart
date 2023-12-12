import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/provider/service_request_provider.dart';
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/models/client_model.dart';

class ServiceDescriptionScreen extends StatefulWidget {
  final String? itemId;

  const ServiceDescriptionScreen({super.key, this.itemId});

  @override
  State<ServiceDescriptionScreen> createState() =>
      _ServiceDescriptionScreenState();
}

class _ServiceDescriptionScreenState extends State<ServiceDescriptionScreen> {
  late List<Client> clientList;
  late ClientProvider clientProvider;
  late ServiceRequestProvider serviceRequestProvider;
  late String selectedValue;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    serviceRequestProvider =
        Provider.of<ServiceRequestProvider>(context, listen: false);
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    clientProvider.getAllClient();
    clientList = clientProvider.clientsModel;
    selectedValue = clientList.first.name;
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ConstantsApp.defaultPadding),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    ConstantsApp.defaultPadding / 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(ConstantsApp.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Añadir Nueva Solicitud de Servcio",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "Descripción",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: ConstantsApp.backgroundColor.withOpacity(.5),
                          border: Border.all(
                            color: Colors.grey.withOpacity(.4),
                            width: .7,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(ConstantsApp.defaultPadding),
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 6,
                            maxLength: 300,
                            style: TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "En este campo deberá describir lo mejor posible el problema a corregir",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding * 2),
                      Text(
                        "Cliente",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      DropdownButton(
                        hint: Text("Selecciona el cliente"),
                        value: selectedValue,
                        borderRadius: BorderRadius.circular(5.0),
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                        items: clientList.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name),
                            value: e.name,
                          );
                        }).toList(),
                      ),
                      SizedBox(height: ConstantsApp.defaultPadding),
                      Text(
                        "En este campo deberá seleccionar el cliente que hace la petición",
                        style: TextStyle(
                          color: Colors.grey.withOpacity(.5),
                          fontSize: 14,
                        ),
                      ),
                      Spacer(),
                      ButtonWidgetSolid(
                        label: "Guardar",
                        onTap: () {
                          serviceRequestProvider.createServiceRequest(
                            ServiceRequest.create(
                              clientId: clientProvider
                                  .clientsModel
                                  .where((element) =>
                              selectedValue == element.name)
                                  .first
                                  .clientId ??
                                  '',
                              description: _descriptionController.text,
                              requestDate: DateTime.now(),
                              state: ServiceRequestState.Pendiente,
                            ),
                          );
                        },
                        solidColor: Colors.blue,
                        borderRadius: 4,
                        icon: Icons.save_rounded,
                        labelAndIconColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
