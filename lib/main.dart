import './Pages/styles/test.dart';
import 'package:mactur_mobile/Pages/DotPage.dart';
import 'package:mactur_mobile/Pages/styles/shared_preferences.dart';

import './Pages/Api/Sheets/SheetsApi.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserSimplePreferences.init();

  await excel_api.init();

  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DotPage(),
    );
  }
}
