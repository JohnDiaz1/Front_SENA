import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/MainScreens/Home/components/navigation_drawer.dart';
import 'package:front_sena/Provider/service_request_provider.dart';
import 'package:front_sena/Provider/client_provider.dart';
import 'package:front_sena/models/client_model.dart';
import 'package:front_sena/models/service_request_model.dart';

class ServiceRequestScreen extends StatefulWidget {
  const ServiceRequestScreen({super.key});

  @override
  State<ServiceRequestScreen> createState() => _ServiceRequestScreenState();
}

class _ServiceRequestScreenState extends State<ServiceRequestScreen> {
  //Provider
  @override
  void initState() {
    Provider.of<ServiceRequestProvider>(context, listen: false)
        .getAllServiceRequests();
    Provider.of<ClientProvider>(context, listen: false).getAllClient();
    super.initState();
  }

  final TextEditingController _descriptionController = TextEditingController();

  void showSheet(BuildContext context) {

    ClientDropdownController _controller = Provider.of<ClientDropdownController>(context, listen: false);
    //String? _selectedClientId = _controller._selectedClient?.clientId;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            top: 30,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descripcion",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                maxLines: 5,
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Describe el problema",
                  hintStyle: TextStyle(
                      fontSize: 13,
                      color: Colors.grey
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Cliente",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ClientDropdown(),
              SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //ServiceRequest service =  ServiceRequest.create(clientId: _controller._selectedClient, description: _descriptionController.text, requestDate: DateTime.now(), state: "Pendiente");
                    //Provider.of<ServiceRequestProvider>(context, listen: false).createServiceRequest(service);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Añadir Solicitud"),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Requests"),
      ),
      drawer: NavigatorDrawer(),
      body: SafeArea(
        child: Consumer<ServiceRequestProvider>(
          builder: (context, value, child) {
            if (value.servicesModel.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: value.servicesModel.length,
                itemBuilder: (BuildContext context, int index) {
                  //return ListItemViews<ServiceRequest>(
                   //   model: value.servicesModel[index],
                   // screenString: "service",
                  //  getIdFunction: (ServiceRequest service) => service.requestId,
                 // );
                },
              );
            }
            return const Center(
              child: Text("Error"),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { showSheet(context);},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ClientDropdown extends StatefulWidget {
  const ClientDropdown({super.key});

  @override
  State<ClientDropdown> createState() => _ClientDropdownState();
}

class _ClientDropdownState extends State<ClientDropdown> {
  late ClientDropdownController _controller;
  late Client _currentValue;
  List<Client> clients = [];

  @override
  void initState() {
    super.initState();
    _controller = Provider.of<ClientDropdownController>(context, listen: false);
    clients = Provider.of<ClientProvider>(context, listen: false).clientsModel;
    if (clients.isNotEmpty) {
      _currentValue = clients.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (_) {
      return InputDecorator(
        decoration: InputDecoration(
          hintText: "Add client",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _currentValue,
            isDense: true,
            onChanged: (Client? newValue) {
              if (newValue != null) {
                setState(() {
                  _currentValue = newValue;
                  _controller.updateSelectedClient(newValue.clientId);
                });
              }
            },
            items: clients.map<DropdownMenuItem<Client>>((Client client) {
              return DropdownMenuItem<Client>(
                child: Text(client.name),
                value: client,
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

class ClientDropdownController extends ChangeNotifier {
  String _selectedClient = "";

  String get selectedClient => _selectedClient;

  void updateSelectedClient(String clientId) {
    _selectedClient = clientId;
    notifyListeners();
  }
}

