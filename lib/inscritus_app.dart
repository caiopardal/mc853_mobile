import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:inscritus/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:inscritus/views/about_app/about.dart';
import 'package:inscritus/views/activities/my_activities.dart';
import 'package:inscritus/views/home/home_screen.dart';
import 'package:inscritus/views/qr_scanner/QRScanner.dart';
import 'package:inscritus/views/speakers/speakers_view.dart';
import 'package:inscritus/views/map/map.dart';

class InscritusApp extends StatefulWidget {
  final String email;
  final String uid;
  final bool isAdmin;

  InscritusApp({
    this.email,
    this.uid,
    this.isAdmin,
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
        HomeScreen(
          email: widget.email,
          uid: widget.uid,
          isAdmin: widget.isAdmin,
        )));

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
          name: "Minhas atividades",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        MyActivities(
          day: '',
          uid: widget.uid,
        ),
      ),
    );

    if (widget.isAdmin)
      items.add(new ScreenHiddenDrawer(
          new ItemHiddenMenu(
            name: "Scans",
            baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
            colorLineSelected: Colors.orange,
          ),
          QRScanner()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Palestrantes",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        SpeakersView()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Mapa",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        Map()));

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
