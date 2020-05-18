import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/qr_scanner/newScanner.dart';

class QRScanner extends StatefulWidget {
  static String userEmail, userPassword;

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  var _isVisible;
  List<String> _locations = [
    'Workshop de Node.js',
    'Workshop de Flutter',
    'Criando uma aplicação Web'
  ]; // Option 2
  String _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 40,
            ),
            child: Center(
              child: DropdownButton(
                hint: Text(
                    'Selecione uma atividade'), // Not necessary for Option 1
                value: _selectedLocation,
                onChanged: (newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    child: new Text(location),
                    value: location,
                  );
                }).toList(),
              ),
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
                  'Scan QR Codes',
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
    );
  }
}
