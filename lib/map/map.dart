import 'package:flutter/material.dart';
import 'package:inscritus/widgets/loading_indicator.dart';
import 'package:inscritus/widgets/transparent_image.dart';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : (0xFF292929),
        alignment: Alignment(0, 0),
        child: PinchZoomImage(
          image: currentOrientation == Orientation.portrait
              ? Stack(
                  children: <Widget>[
                    Center(child: FancyLoadingIndicator()),
                    Center(
                      child: Image(
                        image: AssetImage('assets/map.png'),
                      ),
                    ),
                  ],
                )
              : Stack(
                  children: <Widget>[
                    Center(child: FancyLoadingIndicator()),
                    Center(
                      child: Image(
                        image: AssetImage('assets/map.png'),
                      ),
                    ),
                  ],
                ),
          zoomedBackgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          hideStatusBarWhileZooming: false,
        ),
      ),
    );
  }
}
