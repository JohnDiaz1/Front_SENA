import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/provider/service_request_provider.dart';
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/models/client_model.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/app_header.dart';

class ServiceDescriptionScreen extends StatefulWidget {
  final String? itemId;

  const ServiceDescriptionScreen({super.key, this.itemId});

  @override
  State<ServiceDescriptionScreen> createState() =>
      _ServiceDescriptionScreenState();
}

class _ServiceDescriptionScreenState extends State<ServiceDescriptionScreen> {
  late List<Client> clientList;
  //Iterable<TableRow>? filteredServiceRequestList;
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
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: Column(
          children: [
            AppHeader(),
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: ConstantsApp.defaultPadding * 2,
                          top: ConstantsApp.defaultPadding * 2),
                      child: Text(
                        "Title of Page",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding:
                                  EdgeInsets.all(ConstantsApp.defaultPadding),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ConstantsApp.defaultPadding / 2))),
                              margin: EdgeInsets.only(
                                  top: ConstantsApp.defaultPadding * 2,
                                  left: ConstantsApp.defaultPadding,
                                  right: ConstantsApp.defaultPadding * 2,
                                  bottom: ConstantsApp.defaultPadding * 3),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Descripcion"),
                                          Container(
                                            width: 500,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                color: ConstantsApp
                                                    .backgroundColor
                                                    .withOpacity(.5),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(.4),
                                                    width: .7),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        _descriptionController,
                                                    maxLines: 6,
                                                    maxLength: 300,
                                                    enabled: true,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "En este campo debera describir lo mejor posible el problema a corregir",
                                            style: TextStyle(
                                                color:
                                                    Colors.grey.withOpacity(.5),
                                                fontSize: 14,
                                                height: 10,
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even),
                                          ),
                                          SizedBox(
                                            width:
                                                ConstantsApp.defaultPadding * 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Cliente"),
                                          DropdownButton(
                                            hint: Text("Selecciona el cliente"),
                                            value: selectedValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedValue = newValue!;
                                              });
                                            },
                                            items: clientList?.map((e) {
                                              return DropdownMenuItem(
                                                child: Text(e.name),
                                                value: e.name,
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(
                                            width:
                                                ConstantsApp.defaultPadding / 2,
                                          ),
                                          Text(
                                            "En este campo debera seleccionar el cliente que hace la peticion",
                                            style: TextStyle(
                                                color:
                                                    Colors.grey.withOpacity(.5),
                                                fontSize: 14,
                                                height: 10,
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ButtonWidgetSolid(
                                            label: "Guardar",
                                            onTap: () {
                                              serviceRequestProvider?.createServiceRequest(
                                                  ServiceRequest.create(
                                                      clientId: clientProvider
                                                              ?.clientsModel
                                                              .where((element) =>
                                                                  selectedValue ==
                                                                  element.name)
                                                              .first
                                                              .clientId ??
                                                          '',
                                                      description:
                                                          _descriptionController
                                                              .text,
                                                      requestDate:
                                                          DateTime.now(),
                                                      state: ServiceRequestState
                                                          .Pendiente));
                                            },
                                            solidColor: Colors.blue,
                                            borderRadius: 4,
                                            icon: Icons.save_rounded,
                                            labelAndIconColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*Table(
                    columnWidths: {
                      0: FixedColumnWidth(30),
                      1: FixedColumnWidth(500),
                      2: FixedColumnWidth(400)
                    },
                    border: TableBorder(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(.1), width: 1),
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(.1), width: 1),
                      horizontalInside: BorderSide(
                          color: Colors.grey.withOpacity(.1), width: 1),
                    ),
                    children: [
                      _buildServiceHeader(),
                      ...?serviceRequestList,
                    ],
                  ),*/
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
