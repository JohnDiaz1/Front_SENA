import 'package:flutter/material.dart';

class AssetsImages {

  static final String path = "assets/images/";

  static Image ImageLogo() {
    return Image(
      image: AssetImage('${path}icon/logoSena.png'),
      width: 100,
      height: 100,
    );
  }

  static Image ImageWelcome() {
    return Image(
      image: AssetImage('${path}icon/logoSena.png'),
    );
  }

}