import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:front_sena/provider/client_provider.dart';
import 'package:front_sena/models/client_model.dart';
import 'package:front_sena/widgets/app_header.dart';
import 'package:front_sena/widgets/vertical_side_navigation.dart';
import 'package:front_sena/MainScreens/ServiceRequest/service_description_screen.dart';
import 'package:front_sena/MainScreens/main_content_screen.dart';
import 'package:front_sena/utils/constants_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:front_sena/MainScreens/clients/clients_screen.dart';
import 'package:front_sena/MainScreens/Inventory/inventory_screen.dart';
import 'package:front_sena/MainScreens/employee/employee_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Provider
  @override
  void initState() {
    Provider.of<ClientProvider>(context, listen: false).getAllClient();
    super.initState();
  }

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget buildMainContent({required int currentPage}) {
      switch(currentPage){
        case 0: return MainContent();
        case 1: return ClientsScreen();
        case 2: return InventoryScreen();
        case 3: return EmployeeScreen();
        case 4: return ServiceDescriptionScreen();
        default:
          return const MainContent();
      }
    }

    return Scaffold(
        body: Container(
          color: Colors.black12,
          child: Column(
            children: [
              AppHeader(),
              Expanded(
                  child: Row(
                children: [
                  VerticalSideNavigationMenu(
                    onTap: (int index){
                      print(index);
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    currentIndex: currentIndex,
                    menuItems: [
                      NavBarMenuItem(icon: CupertinoIcons.home),
                      NavBarMenuItem(icon: CupertinoIcons.group_solid),
                      NavBarMenuItem(icon: CupertinoIcons.square_list),
                      NavBarMenuItem(icon: CupertinoIcons.briefcase),
                    ],
                    iconSize: 17,
                  ),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: ConstantsApp.defaultPadding * 2, top: ConstantsApp.defaultPadding * 2),
                            child: Text(
                                "Title of Page",
                              style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black),
                            ),
                          ),
                          Expanded(
                              child: buildMainContent(currentPage: currentIndex)
                          ),
                        ],
                      )
                  )
                ],
              )
              )
            ],
          ),
        )
    );
  }
}

