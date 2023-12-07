import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:front_sena/widgets/button_widget_icon.dart';
import 'package:front_sena/Provider/service_request_provider.dart';
import 'package:front_sena/Provider/client_provider.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/models/service_request_model.dart';
import 'package:front_sena/widgets/pagination_widget.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/button_widget_popup.dart';
import 'package:front_sena/MainScreens/ServiceRequest/service_description_screen.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  Iterable<TableRow>? serviceRequestList;
  late Iterable<TableRow> filteredServiceRequestList;
  ServiceRequestProvider? provider;
  ClientProvider? clientProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        clientProvider = Provider.of<ClientProvider>(context, listen: false);
        clientProvider?.getAllClient();
        provider = Provider.of<ServiceRequestProvider>(context, listen: false);
        provider?.getAllServiceRequests();
        serviceRequestList = provider?.servicesModel
            .map((service) => _buildServiceRowTile(service));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 400,
                          height: 40,
                          decoration: BoxDecoration(
                              color:
                                  ConstantsApp.backgroundColor.withOpacity(.5),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(.4),
                                  width: .7),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    ConstantsApp.defaultPadding / 2),
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: Colors.grey.withOpacity(.8),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: ConstantsApp.defaultPadding),
                                    child: TextField(
                                      enabled: true,
                                      onChanged: (searchTerm) {
                                        if (searchTerm.isEmpty) {
                                          setState(() {
                                            serviceRequestList = provider?.servicesModel
                                                .map((element) => _buildServiceRowTile(element));
                                          });
                                        } else {
                                          setState(() {
                                            serviceRequestList = provider?.servicesModel
                                                .where((element) =>
                                                element.description.toLowerCase().contains(searchTerm.toLowerCase()))
                                                .map((element) => _buildServiceRowTile(element));
                                          });
                                        }
                                      },
                                      style: TextStyle(fontSize: 12),
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    )),
                              ),
                              ButtonWidgetWithIcon(
                                  icon: Icons.keyboard_arrow_down_outlined,
                                  label: "Filtrar",
                                  onTap: () {
                                    print("Filter Click");
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: ConstantsApp.defaultPadding / 2,
                        ),
                        Row(
                          children: [
                            ButtonWidgetWithIcon(
                                borderColor: Colors.blue,
                                borderRadius: 4,
                                labelAndIconColor: Colors.blue,
                                icon: Icons.keyboard_arrow_down_outlined,
                                label: "Export",
                                onTap: () {
                                  print("Export click");
                                }),
                            SizedBox(
                              width: ConstantsApp.defaultPadding / 2,
                            ),
                            ButtonWidgetSolid(
                                label: "Nuevo Cliente",
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDescriptionScreen()));
                                },
                              labelAndIconColor: Colors.white,
                              solidColor: Colors.blue,
                              borderRadius: 4,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Table(
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
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PaginationWidget()
          ],
        ),
        SizedBox(
          height: ConstantsApp.defaultPadding * 3,
        )
      ],
    );
  }

  TableRow _buildServiceRowTile(ServiceRequest serviceRequest) {
    return TableRow(key: ValueKey(serviceRequest.requestId), children: [
      _buildServiceItem(
          child: Checkbox(
        value: false,
        onChanged: (value) {},
        side: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        focusColor: Colors.black45,
      )),
      _buildServiceItem(
          child: Padding(
        padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
        child: Text(
          serviceRequest.description,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black87.withOpacity(.7)),
        ),
      )),
      _buildServiceItem(
          child: Padding(
        padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
        child: Text(
          clientProvider?.clientsModel.where((element) => serviceRequest.clientId == element.clientId).first.name ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black87.withOpacity(.7)),
        ),
      )),
      _buildServiceItem(
          child: Padding(
        padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
        child: Text(
          serviceRequest.requestDate.toIso8601String(),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black87.withOpacity(.7)),
        ),
      )),
      _buildServiceItem(
          child: Padding(
        padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
        child: Container(
          height: 35,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: serviceRequestStateColor(serviceRequest.state),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: Text(
              serviceRequestState(serviceRequest.state),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black87.withOpacity(.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      )),
      TableCell(
          child: Container(
        padding:
            EdgeInsets.symmetric(vertical: ConstantsApp.defaultPadding + 6),
        child: Center(
          child: ButtonWidgetPopUp(
            menuItems: [
              PopupMenuItemData(
                icon: Icons.edit,
                iconColor: Colors.blue,
                text: "Editar",
                onTap: () {
                  // Lógica para la opción "Editar"
                },
              ),
              PopupMenuItemData(
                icon: Icons.delete,
                iconColor: Colors.red,
                text: "Eliminar",
                onTap: () {
                  // Lógica para la opción "Eliminar"
                  setState(() {
                    provider?.deleteServiceRequestById(serviceRequest.requestId.toString());
                  });
                },
              ),
              // Agrega más elementos de menú según sea necesario
            ],
          )
          ,
        ),
      )),

      /*_buildServiceItem( //Para cargar una imagen
              child: Image.network(
                photho,
                errorBuilder: (context, err, _) {
                  return Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.rectangle
                    ),
                  )
                },
              )),*/
    ]);
  }

  TableRow _buildServiceHeader() {
    return TableRow(children: [
      _buildServiceItem(
          child: Padding(
        padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
        child: Checkbox(value: false, onChanged: (value) {}),
      )),
      //_buildServiceItem(child: Container()),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Descripcion"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Client"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Fecha de Solicitud"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Estado"))),
      _buildServiceItem(child: Container()),
    ]);
  }

  TableCell _buildServiceItem({required Widget child}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
        height: 70,
        child: Center(
          child: child,
        ),
      ),
    );
  }

  serviceRequestState(ServiceRequestState state) {
    switch (state) {
      case ServiceRequestState.Activo:
        return "Activo";
      case ServiceRequestState.Pendiente:
        return "Pendiente";
      case ServiceRequestState.Finalizado:
        return "Finalizado";
      case ServiceRequestState.Cancelado:
        return "Cancelado";
    }
  }

  serviceRequestStateColor(ServiceRequestState state) {
    switch (state) {
      case ServiceRequestState.Activo:
        return Colors.green.withOpacity(.3);
      case ServiceRequestState.Pendiente:
        return Colors.yellow.withOpacity(.3);
      case ServiceRequestState.Finalizado:
        return Colors.blue.withOpacity(.3);
      case ServiceRequestState.Cancelado:
        return Colors.red.withOpacity(.3);
    }
  }
}
