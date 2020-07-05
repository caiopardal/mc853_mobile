import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/views/qr_scanner/newScanner.dart';
import 'package:inscritus/views/qr_scanner/scanner_dropdown.dart';
import 'package:provider/provider.dart';

class QRScanner extends StatefulWidget {
  static String userEmail, userPassword;

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  var _isVisible = false;
  String _selectedLocation;

  void onChange(String newValue) {
    setState(() {
      _selectedLocation = newValue;
      _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: DatabaseService().activities,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: ScannerDropdown(
                onChange: onChange,
                selectedLocation: _selectedLocation,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (_isVisible == false)
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 14,
                      ),
                      child: Text(
                        'Selecione a atividade atrelada ao QR Code para continuar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Container(
                    height: 300.0,
                    child: FlareActor(
                      'assets/flare/forever_wondering.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "idle",
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width - 50,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: _isVisible == false
              ? null
              : new FloatingActionButton.extended(
                  backgroundColor: Colors.yellow,
                  splashColor: Color(0xFFC85151),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            NewScanner(eventName: _selectedLocation),
                      ),
                    );
                  },
                  tooltip: 'QRCode Reader',
                  icon: Center(
                    child: Icon(
                      GroovinMaterialIcons.qrcode_scan,
                      color: Color(0xFF1A1A1A),
                      semanticLabel: 'QR Scanner Icon',
                    ),
                  ),
                  label: Text(
                    'Escanear QR Codes',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF1A1A1A),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      ),
    );
  }
}
