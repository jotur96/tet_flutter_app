import 'package:flutter/material.dart';


class AppTheme {

  ThemeData getTheme() {
    const seeColor = Color.fromARGB(255, 6, 68, 10);

    return ThemeData( 
      brightness: Brightness.dark,        
      useMaterial3: true,
      colorSchemeSeed: seeColor,
      listTileTheme: const ListTileThemeData(
        iconColor: seeColor,
      )
    );
  }
}