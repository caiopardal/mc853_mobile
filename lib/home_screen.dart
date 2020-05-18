// if (index == 0)
//   Navigator.of(context).pushNamed('/home');
// else if (index == 1) Navigator.of(context).pushNamed('/about');

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/about_app/about.dart';
import 'package:inscritus/dashboard/dashboard.dart';
import 'package:inscritus/events/events.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc/authentication_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  static String routeName = '/home';

  HomeScreen({Key key, @required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentBottomNavItemIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  ///===========================================================
  ///                     BOTTOM NAV PAGES
  ///===========================================================
  final _bottomNavPages = <Widget>[
    // About(),
    Dashboard(),
    Events(),
  ];

  ///===========================================================
  ///                      BOTTOM APP BAR
  ///===========================================================
  BottomAppBar _buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      elevation: 25.0,
      notchMargin: 6.0,
      color: Color(0xFFE1F5FE),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: InkResponse(
              onTap: () {
                setState(() {
                  _currentBottomNavItemIndex = 0;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      size: 25.0,
                      color: _currentBottomNavItemIndex == 0
                          ? Color(0xFF1E90FF)
                          : Colors.black,
                    ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: _currentBottomNavItemIndex == 0 ? 14.0 : 12.0,
                        color: _currentBottomNavItemIndex == 0
                            ? Color(0xFF1E90FF)
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Expanded(
            flex: 2,
            child: InkResponse(
              onTap: () {
                setState(() {
                  _currentBottomNavItemIndex = 1;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      GroovinMaterialIcons.calendar_clock,
                      size: 25.0,
                      color: _currentBottomNavItemIndex == 1
                          ? Color(0xFF1E90FF)
                          : Colors.black,
                    ),
                    Text(
                      'Eventos',
                      style: TextStyle(
                        fontSize: _currentBottomNavItemIndex == 1 ? 14.0 : 12.0,
                        color: _currentBottomNavItemIndex == 1
                            ? Color(0xFF1E90FF)
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///===========================================================
  ///                      SHOW QR-CODE
  ///===========================================================
  void _showQrCode() async {
    var userEmail = widget.email;
    switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          children: <Widget>[
            Container(
              height: 250.0,
              width: 400.0,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: QrImage(
                      version: 4,
                      data: userEmail ?? '',
                      gapless: true,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    )) {
    }
  }

  ///===========================================================
  ///                     BUILD FUNCTION
  ///===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Inscritus'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          )
        ],
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xFFE0F2F1),
      body: _bottomNavPages[_currentBottomNavItemIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showQrCode();
        },
        child: Icon(
          GroovinMaterialIcons.qrcode,
          size: 34,
        ),
        tooltip: 'QR Code',
        elevation: 4.0,
        splashColor: Colors.white,
        isExtended: false,
        foregroundColor: Colors.black,
        backgroundColor: Color(0xFF1E90FF),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }
}
