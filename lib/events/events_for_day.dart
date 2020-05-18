import 'package:flutter/material.dart';
import 'package:inscritus/models/models.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';

class EventCard extends StatefulWidget {
  EventCard({@required this.resource, @required this.day});
  final Event resource;
  final String day;

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool isExpanded = false;

  Widget build(BuildContext context) {
    Brightness _brightnessValue = MediaQuery.of(context).platformBrightness;
    var time = DateFormat('hh:mm a').format(widget.resource.start.toLocal());
    var date = DateFormat.d().format(widget.resource.start.toLocal());
    var today = DateTime.now().day.toString();
    if (date == widget.day || date == today) {
      return Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          color: (isExpanded)
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
          child: ExpansionTile(
            onExpansionChanged: (bool expanding) =>
                setState(() => this.isExpanded = expanding),
            leading: new Text(
              time ?? '',
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: isExpanded
                    ? (_brightnessValue == Brightness.light
                        ? Colors.yellow.shade500
                        : Color(0xFF1E90FF))
                    : Theme.of(context).primaryColor,
                textBaseline: TextBaseline.alphabetic,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: isExpanded
                  ? Colors.white
                  : (_brightnessValue == Brightness.light
                      ? Color(0xFF1E90FF)
                      : Colors.white),
              size: 35.0,
            ),
            title: new Text(
              widget?.resource?.summary ?? '',
              style: new TextStyle(
                color: isExpanded
                    ? Colors.white
                    : (_brightnessValue == Brightness.light
                        ? Color(0xFF1E90FF)
                        : Colors.white),
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                  bottom: 15.0,
                ),
                child: PinchZoomImage(
                  image: Image.asset(
                      'assets/map/' + widget.resource.location + '.png'),
                  zoomedBackgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                  hideStatusBarWhileZooming: false,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}

class EventsForDay extends StatelessWidget {
  final String day;
  final List<Event> events;
  EventsForDay({
    Key key,
    @required this.day,
    @required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: new ListView.builder(
          padding: EdgeInsets.all(15.0),
          itemCount: events == null ? 1 : events.length,
          itemBuilder: (BuildContext context, int index) {
            return new EventCard(
              resource: events[index],
              day: this.day,
            );
          },
        ),
      ),
    );
  }
}
