import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: .7
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: ConstantsApp.defaultPadding),
            child: Row(
              children: [
                Text(
                  "SERVICE",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                  ),
            ),
                  Text(
                    "APP",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ConstantsApp.defaultPadding),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    color: Colors.grey
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 17,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(width: ConstantsApp.defaultPadding,),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green
                  ),
                  child: Center(
                    child: Text(
                      "JD",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12),
                    ),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
