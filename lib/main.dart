import 'package:flutter/material.dart';
import 'src/constants/constants.dart';
import 'src/pages/main/main_page.dart';
import "package:flutter/foundation.dart";

void main() async {
  if (defaultTargetPlatform == TargetPlatform.linux ||
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    WidgetsFlutterBinding.ensureInitialized();
    // await windowManager.ensureInitialized();
    // //windowManager.setFullScreen(true);
    // WindowOptions windowOptions = const WindowOptions(
    //   size: Size(1300, 1000),
    //   center: true,
    // );
    // windowManager.waitUntilReadyToShow(windowOptions, () async {
    //   await windowManager.show();
    //   await windowManager.focus();
    // });
  }
  runApp(MaterialApp(
    theme: ThemeData(
      textTheme: const TextTheme(
        bodyText1: AppTextStyles.p,
        bodyText2: AppTextStyles.p,
      ),
    ),
    home: MainPage(),
  ));
}
