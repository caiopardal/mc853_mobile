import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:inscritus/about_app/about.dart';
import 'package:inscritus/home_screen.dart';

import 'authentication_bloc/authentication_bloc.dart';

class InscritusApp extends StatefulWidget {
  final String email;

  InscritusApp({
    this.email,
  });

  @override
  _InscritusAppState createState() => _InscritusAppState();
}

class _InscritusAppState extends State<InscritusApp> {
  List<ScreenHiddenDrawer> items = List();

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Início",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        HomeScreen(email: widget.email)));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Sobre nós",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        About()));

    items.add(
      new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Sair do app",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
          onTap: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              LoggedOut(),
            );
          },
        ),
        Container(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: items,
      backgroundColorMenu: Colors.cyan,
      backgroundMenu: DecorationImage(
        image: ExactAssetImage('assets/flutter_logo.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
