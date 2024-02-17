import 'package:flutter/material.dart';
import 'package:front_sena/MainScreens/main_content_screen.dart';
import 'package:front_sena/MainScreens/serviceRequest/add_new_service_request_screen.dart';

Widget buildMainContent({required int currentPage}) {
  switch (currentPage) {
    case 0:
      return MainContent();
    case 1:
      return Container();
    case 2:
      return Container();
    case 3:
      return Container();
    default:
      return const MainContent();
  }
}
