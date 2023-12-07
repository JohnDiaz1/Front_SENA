import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:front_sena/Provider/inventory_provider.dart';
import 'package:front_sena/models/inventory_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:front_sena/widgets/button_widget_popup.dart';
import 'package:front_sena/widgets/button_widget_solid.dart';
import 'package:front_sena/widgets/button_widget_icon.dart';
import 'package:front_sena/widgets/pagination_widget.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  Iterable<TableRow>? inventoryList;
  late Iterable<TableRow> filteredServiceRequestList;
  InventoryProvider? provider;

  //Provider
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        provider = Provider.of<InventoryProvider>(context, listen: false);
        provider?.getAllItems();
        inventoryList = provider?.inventoryModel
            .map((item) => _buildServiceRowTile(item));
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
                                            inventoryList = provider?.inventoryModel
                                                .map((element) => _buildServiceRowTile(element));
                                          });
                                        } else {
                                          setState(() {
                                            inventoryList = provider?.inventoryModel
                                                .where((element) =>
                                                element.name.toLowerCase().contains(searchTerm.toLowerCase()))
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
                              label: "Nuevo Item",
                              onTap: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDescriptionScreen()));
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
                      ...?inventoryList,
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

  TableRow _buildServiceRowTile(Inventory item) {
    return TableRow(key: ValueKey(item.inventoryId), children: [
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
              item.name,
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
              item.description,
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
              item.precioCompra.toString(),
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
              item.precioVenta.toString(),
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
                color: inventoryStockColor(item.stock),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  item.stock.toString(),
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
                        //provider?.deleteServiceRequestById(serviceRequest.requestId.toString());
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
              child: Text("Nombre"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Descripcion"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Precio Compra"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Precio Venta"))),
      _buildServiceItem(
          child: Padding(
              padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
              child: Text("Stock"))),
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

  inventoryStockColor(int stock) {
    if (stock >= 0 && stock <= 15) {
      return Colors.red.withOpacity(0.3);
    } else if (stock > 15 && stock <= 45) {
      return Colors.yellow.withOpacity(0.3);
    } else if (stock > 45) {
      return Colors.green.withOpacity(0.3);
    } else {
      return Colors.grey.withOpacity(0.3);
    }
  }

}
