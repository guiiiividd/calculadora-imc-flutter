import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Colors.black;
  static const Color primaryColor = Colors.green;
  static const Color appBarIconColor = Colors.white;
}

class AppStyles {
  static const TextStyle appBarText = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );

  static const TextStyle fontBlack = TextStyle(color: AppColors.black);

  static const TextStyle linkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
    decorationColor: Colors.blue,
    fontFamily: 'Roboto',
  );

  static const TextStyle titleText = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );

  static const TextStyle buttonText = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
  );

  static const TextStyle defaultText = TextStyle(
    fontSize: 20,
    color: AppColors.black,
    fontFamily: 'Roboto',
  );

  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static ButtonStyle transparentButtonStyle = TextButton.styleFrom(
    backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
    foregroundColor: Colors.blue,
    overlayColor: Colors.transparent,
    padding: EdgeInsets.zero,
  );
}

class AppSpacing {
  static const double bodyPadding = 20;
  static const double sizedBoxHeight = 20;
}

class AppSize {
  static const double bodyIconSize = 120;
}
