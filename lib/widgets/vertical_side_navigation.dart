import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';

class VerticalSideNavigationMenu extends StatefulWidget {
  final List<NavBarMenuItem> menuItems;
  final Function(int index)? onTap;
  final int? currentIndex;
  final double iconSize;

  const VerticalSideNavigationMenu(
      {super.key,
      required this.menuItems,
      this.onTap,
      this.currentIndex,
      required this.iconSize});

  @override
  State<VerticalSideNavigationMenu> createState() =>
      _VerticalSideNavigationMenuState();
}

class _VerticalSideNavigationMenuState
    extends State<VerticalSideNavigationMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
      width: 80,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.black12, width: .7),
        ),
      ),
      child: Column(
        children: [
          ...widget.menuItems.map(
            (menu) => InkWell(
              onTap: () => widget.onTap!(widget.menuItems.indexOf(menu)),
              child: Padding(
                padding: EdgeInsets.only(top: ConstantsApp.defaultPadding * 2),
                child: Icon(
                  menu.icon,
                  color: widget.currentIndex == widget.menuItems.indexOf(menu)
                      ? Colors.blueAccent
                      : Colors.black45,
                  size: widget.iconSize,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NavBarMenuItem {
  final IconData icon;

  NavBarMenuItem({required this.icon});
}
