import 'package:flutter/material.dart';
import 'package:front_sena/utils/constants_app.dart';

class ButtonWidgetSolid extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color? solidColor;
  final Color? labelAndIconColor;
  final double? borderRadius;
  final Function() onTap;

  const ButtonWidgetSolid(
      {super.key,
        required this.label,
        this.icon,
        this.solidColor,
        this.labelAndIconColor,
        this.borderRadius,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: solidColor ?? Colors.blue.withOpacity(.4),
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ConstantsApp.defaultPadding / 2),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: labelAndIconColor ?? Colors.grey.withOpacity(.7)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(ConstantsApp.defaultPadding / 2),
                child: Icon(
                  icon,
                  color: labelAndIconColor ?? Colors.grey.withOpacity(.8),
                  size: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
