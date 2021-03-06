import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:inscritus/models/user.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/views/about_app/about.dart';
import 'package:inscritus/views/activities/activities.dart';
import 'package:inscritus/views/dashboard/dashboard.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String email;
  final String uid;
  final bool isAdmin;
  static String routeName = '/home';

  HomeScreen({
    Key key,
    @required this.email,
    @required this.uid,
    @required this.isAdmin,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentBottomNavItemIndex = 0;
  List<ScreenHiddenDrawer> items = List();
  User user;

  @override
  void initState() {
    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "About",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        InformationScreen()));

    items.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Activities",
          baseStyle: TextStyle(color: Colors.black, fontSize: 28.0),
          colorLineSelected: Colors.orange,
        ),
        Activities(
          uid: widget.uid,
        )));

    DatabaseService.getUserById(widget.uid).then((value) {
      user = value;
    });

    super.initState();
  }

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
                      'Início',
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
                      'Atividades',
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
    await showDialog(
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
              height: 300.0,
              width: 400.0,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: QrImage(
                      version: 4,
                      data: widget.uid ?? '',
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
    );
  }

  ///===========================================================
  ///                     BUILD FUNCTION
  ///===========================================================

  @override
  Widget build(BuildContext context) {
    final _bottomNavPages = <Widget>[
      // About(),
      Dashboard(),
      Activities(
        uid: widget.uid,
      ),
    ];

    return Scaffold(
      key: _scaffoldKey,
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
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF1E90FF),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }
}
