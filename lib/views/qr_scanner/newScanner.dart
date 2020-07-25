import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/services/database.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class NewScanner extends StatefulWidget {
  final String eventName;
  final String eventID;

  NewScanner({
    this.eventName,
    this.eventID,
  });

  @override
  State<StatefulWidget> createState() => _NewScannerState();
}

class _NewScannerState extends State<NewScanner>
    with SingleTickerProviderStateMixin {
  var qrText = "";
  var scanned = "";
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  AnimationController _animationController;
  // bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.yellow,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
            flex: 5,
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text(
                    widget.eventName,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  new Text(
                    scanned,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFe06969),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // new Container(
                  //   child: IconButton(
                  //     iconSize: 80,
                  //     icon: Icon(
                  //       isPlaying
                  //           ? GroovinMaterialIcons.play_circle
                  //           : GroovinMaterialIcons.pause_circle,
                  //       color: isPlaying ? Colors.yellow : Color(0xFFe06969),
                  //     ),
                  //     onPressed: () => _handleOnPressed(),
                  //   ),
                  // ),
                ],
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    var prevQR = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx';
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData != prevQR) {
          qrText = scanData;
          prevQR = scanData;
          scanned = "";
          _qrRequest(scanData);
        } else {
          scanned = "O e-mail lido é o mesmo escaneado anteriormente!";
        }
      });
    });
  }

  // void _handleOnPressed() {
  //   setState(() {
  //     isPlaying = !isPlaying;
  //     if (isPlaying) {
  //       _animationController.forward();
  //       controller?.pauseCamera();
  //     } else {
  //       _animationController.reverse();
  //       controller?.resumeCamera();
  //     }
  //   });
  // }

  void _qrRequest(String scanData) async {
    var checkIfItIsAValidUID = scanData.isNotEmpty && scanData.length >= 28;
    var message;

    if (checkIfItIsAValidUID) {
      bool exists = await DatabaseService.checkIfEmailIsAlreadyConfirmed(
          widget.eventID, scanData);
      if (!exists) {
        message = "Usuário confirmado na atividade com sucesso!";
        await DatabaseService.confirmAnEmailToActivity(
            widget.eventID, scanData);
        _scanDialogSuccess(message);
      } else {
        message = "Usuário já confirmado anteriormente!";
        _scanDialogWarning(message);
      }
    } else {
      _scanDialogWarning(
          "O QR Code escaneado não apresenta um usuário válido!");
    }
  }

  void _scanDialogSuccess(String body) async {
    switch (await showDialog(
      context: context,
      builder: (BuildContext context, {barrierDismissible: false}) {
        return new AlertDialog(
          backgroundColor: Color(0xFF228B22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Icon(
            Icons.check_circle_outline,
            color: Color(0xFFfff5e8),
            size: 80.0,
          ),
          content: Text(body,
              style: TextStyle(fontSize: 25, color: Color(0xFFfff5e8)),
              textAlign: TextAlign.center),
          actions: <Widget>[
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              splashColor: Colors.yellow,
              height: 40.0,
              color: Color(0xFFfff5e8),
              onPressed: () {
                Navigator.pop(context, true);
              },
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'OK',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFC85151),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    )) {
    }
  }

  Future<bool> _scanDialogWarning(String body) async {
    return showDialog(
      context: context,
      builder: (BuildContext context, {barrierDismissible: false}) {
        return new AlertDialog(
          backgroundColor: Color(0xFFC85151),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Icon(
            Icons.warning,
            color: Color(0xFFfff5e8),
            size: 80.0,
          ),
          content: Text(body,
              style: TextStyle(fontSize: 25, color: Color(0xFFfff5e8)),
              textAlign: TextAlign.center),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCELAR',
                  style: TextStyle(fontSize: 20, color: Color(0xFF592323)),
                  textAlign: TextAlign.center),
              padding: const EdgeInsets.all(15.0),
              splashColor: Color(0xFFfff5e8),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              splashColor: Colors.yellow,
              height: 40.0,
              color: Color(0xFFfff5e8),
              onPressed: () async {
                Navigator.pop(context, true);
              },
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'OK',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFC85151),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
