import 'package:inscritus/models/models.dart';
import 'package:inscritus/models/string_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementCard extends StatelessWidget {
  AnnouncementCard({@required this.resource});
  final Announcement resource;

  Widget build(BuildContext context) {
    String secs = resource.ts.split(".")[0];
    var timeStr =
        DateTime.fromMillisecondsSinceEpoch(int.parse(secs) * 1000).toLocal();
    var formattedTime = new DateFormat('hh:mm a').format(timeStr);

    return new Container(
      key: Key(resource.ts),
      child: new Card(
        elevation: 0.0,
        color: Theme.of(context).dividerColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: StringParser(
                  text: resource.text ?? '',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Source credit for following class: https://cutt.ly/mwdVxtM
/// =================================================
///           VERTICAL GESTURE RECOGNIZER
/// =================================================

class PlatformViewVerticalGestureRecognizer
    extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer({PointerDeviceKind kind})
      : super(kind: kind);

  Offset _dragDistance = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    _dragDistance = _dragDistance + event.delta;
    if (event is PointerMoveEvent) {
      final double dy = _dragDistance.dy.abs();
      final double dx = _dragDistance.dx.abs();

      if (dy > dx && dy > kTouchSlop) {
        // vertical drag - accept
        resolve(GestureDisposition.accepted);
        _dragDistance = Offset.zero;
      } else if (dx > kTouchSlop && dx > dy) {
        // horizontal drag - stop tracking
        stopTrackingPointer(event.pointer);
        _dragDistance = Offset.zero;
      }
    }
  }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
