import 'package:MC853_Mobile/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Inscritus());
}

class Inscritus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("pt_BR", null);
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          brightness: Brightness.dark,
          color: Colors.transparent,
          // This removes the shadow from all App Bars.
        ),
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(255, 135, 80, 1),
        primaryColorDark: Color(0xFF000034),
        fontFamily: 'Montserrat',
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(17, 30, 43, 1),
              ),
            ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (ctx) => HomePage(
              title: "Inscritus",
            ),
      },
    );
  }
}
