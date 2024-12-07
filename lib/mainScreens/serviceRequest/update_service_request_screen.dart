import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:front_sena/widgets/app_header_back.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/provider/service_request_provider.dart';
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/models/client_model.dart';

class UpdateServiceRequestScreen extends StatefulWidget {
  final String serviceId;

  const UpdateServiceRequestScreen({super.key, required this.serviceId});

  @override
  State<UpdateServiceRequestScreen> createState() =>
      _UpdateServiceRequestScreenState();
}

class _UpdateServiceRequestScreenState
    extends State<UpdateServiceRequestScreen> {
  late List<Client> clientList;
  late ClientProvider clientProvider;
  late ServiceRequestProvider serviceRequestProvider;
  String? selectedValue;
  String? selectedValueState;
  late TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    serviceRequestProvider =
        Provider.of<ServiceRequestProvider>(context, listen: false);
    clientProvider = Provider.of<ClientProvider>(context, listen: false);
    clientProvider.getAllClient();
    clientList = clientProvider.clientsModel;
    _loadServiceRequestData();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  Future<ServiceRequest> _loadServiceRequestData() async {
    await serviceRequestProvider.getServiceRequestById(widget.serviceId);
    if (mounted) {
      _descriptionController = TextEditingController(
          text: serviceRequestProvider.serviceModel!.description);
      selectedValue = clientList
          .where((element) =>
              serviceRequestProvider.serviceModel!.clientId == element.clientId)
          .first
          .clientId;
      selectedValueState = serviceRequestProvider.serviceModel!.state.name;
      setState(() {});
      return serviceRequestProvider.serviceModel!;
    }
    throw Exception("No");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeaderBack(),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(ConstantsApp.defaultPadding),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ConstantsApp.defaultPadding / 2))),
              margin: EdgeInsets.only(
                  top: ConstantsApp.defaultPadding * 2,
                  left: ConstantsApp.defaultPadding,
                  right: ConstantsApp.defaultPadding * 2,
                  bottom: ConstantsApp.defaultPadding * 3),
              child: serviceRequestProvider.serviceModel == null ||
                      clientProvider.clientsModel == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Editar Solicitud de servicio",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
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
                              color:
                                  ConstantsApp.backgroundColor.withOpacity(.5),
                              border: Border.all(
                                color: Colors.grey.withOpacity(.4),
                                width: .7,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  ConstantsApp.defaultPadding),
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
                                value: e.clientId,
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
                          SizedBox(height: ConstantsApp.defaultPadding),
                          Text(
                            "Estado",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownButton(
                            hint: Text("Selecciona el estado"),
                            value: selectedValueState,
                            borderRadius: BorderRadius.circular(5.0),
                            onChanged: (newValue) {
                              setState(() {
                                selectedValueState = newValue!;
                              });
                            },
                            items: ServiceRequestState.values.map((e) {
                              return DropdownMenuItem(
                                child: Text(e.name),
                                value: e.name,
                              );
                            }).toList(),
                          ),
                          SizedBox(height: ConstantsApp.defaultPadding),
                          Container(
                            child: ButtonWidgetSolid(
                              label: "Guardar",
                              onTap: () async {
                                bool response = await serviceRequestProvider
                                    .updateServiceRequest(ServiceRequest(
                                        requestId: widget.serviceId,
                                        clientId: serviceRequestProvider
                                            .serviceModel!.clientId,
                                        description:
                                            _descriptionController.text,
                                        requestDate: serviceRequestProvider
                                            .serviceModel!.requestDate,
                                        state: ServiceRequest
                                            .parseServiceRequestStateToString(
                                                selectedValueState)));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      response
                                          ? '¡Solicitud de servicio creada exitosamente!'
                                          : 'Error al crear la solicitud de servicio',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor:
                                        response ? Colors.green : Colors.red,
                                  ),
                                );
                              },
                              solidColor: Colors.blue,
                              borderRadius: 4,
                              icon: Icons.save_rounded,
                              labelAndIconColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
