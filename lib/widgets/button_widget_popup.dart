import 'package:flutter/material.dart';

class PopupMenuItemData {
  final IconData icon;
  final Color iconColor;
  final String text;
  final VoidCallback onTap;

  PopupMenuItemData({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.onTap,
  });
}

class ButtonWidgetPopUp extends StatelessWidget {
  final List<PopupMenuItemData> menuItems;

  const ButtonWidgetPopUp({Key? key, required this.menuItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => _buildPopupMenuItems(),
    );
  }

  List<PopupMenuItem<PopupMenuItemData>> _buildPopupMenuItems() {
    return menuItems.map((item) {
      return PopupMenuItem<PopupMenuItemData>(
        onTap: item.onTap,
        value: item,
        child: _buildMenuItemContent(item),
      );
    }).toList();
  }

  Widget _buildMenuItemContent(PopupMenuItemData item) {
    return InkWell(
      child: Row(
        children: [
          Icon(
            item.icon,
            color: item.iconColor,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(item.text),
          ),
        ],
      ),
    );
  }
}