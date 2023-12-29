import 'package:flutter/material.dart';
import 'package:front_sena/models/inventory_model.dart';
import 'package:front_sena/provider/inventory_provider.dart';
import 'package:provider/provider.dart';

import '../../Utils/constants_app.dart';
import '../../widgets/app_header_back.dart';
import '../../widgets/button_widget_solid.dart';

class UpdateItemScreen extends StatefulWidget {
  final String itemId;

  const UpdateItemScreen({super.key, required this.itemId});

  @override
  State<UpdateItemScreen> createState() => _UpdateItemScreenState();
}

class _UpdateItemScreenState extends State<UpdateItemScreen> {
  late InventoryProvider inventoryProvider;

  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _stockController = TextEditingController();
  late TextEditingController _precioVentaController = TextEditingController();
  late TextEditingController _precioCompraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inventoryProvider = Provider.of<InventoryProvider>(context, listen: false);
    _loadItemData();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _precioVentaController.dispose();
    _precioCompraController.dispose();
  }

  Future<Inventory> _loadItemData() async {
    await inventoryProvider.getItemById(widget.itemId);
    if (mounted) {
      _nameController = TextEditingController(text: inventoryProvider.itemModel?.name);
      _descriptionController = TextEditingController(text: inventoryProvider.itemModel?.description);
      _stockController = TextEditingController(text: inventoryProvider.itemModel!.stock.toString());
      _precioVentaController = TextEditingController(text: inventoryProvider.itemModel!.precioVenta.toString());
      _precioCompraController = TextEditingController(text: inventoryProvider.itemModel!.precioCompra.toString());
      setState(() {}); // Redibujar la interfaz después de obtener los datos
      return inventoryProvider.itemModel!;
    }
    throw Exception("No");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          AppHeaderBack(),
          Flexible(child: Container(
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
            child: inventoryProvider.itemModel == null
                ? Center(
              child: CircularProgressIndicator(),
            )
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Editar Item",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "Nombre",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el nombre del producto",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Descripcion",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar la descripcion del producto",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Cantidad",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _stockController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar la cantidad disponible del producto",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Precio de compra",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _precioCompraController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el precio de compra del producto",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding * 2),
                  Text(
                    "Precio de venta",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _precioVentaController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Text(
                    "En este campo deberá ingresar el precio de venta del producto",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(.5),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ConstantsApp.defaultPadding),
                  Container(
                    child: ButtonWidgetSolid(
                      label: "Guardar",
                      onTap: () {
                        inventoryProvider.updateItem(
                            Inventory(
                                inventoryId: inventoryProvider.itemModel!.inventoryId ,
                                name: _nameController.text,
                                description: _descriptionController.text,
                                stock: int.parse(_stockController.text),
                                precioCompra: double.parse(_precioCompraController.text),
                                precioVenta: double.parse(_precioVentaController.text)
                            ));
                      },
                      solidColor: Colors.blue,
                      borderRadius: 4,
                      icon: Icons.save_rounded,
                      labelAndIconColor: Colors.white,
                    ),
                  ),
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
