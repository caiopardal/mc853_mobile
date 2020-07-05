import 'package:flutter/material.dart';
import 'package:inscritus/helpers/utils.dart';
import 'package:inscritus/models/activity.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
import 'package:provider/provider.dart';

class ActivityCard extends StatefulWidget {
  ActivityCard({
    @required this.resource,
    @required this.day,
  });

  final Activity resource;
  final String day;

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool isExpanded = false;

  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    Brightness _brightnessValue = MediaQuery.of(context).platformBrightness;
    var eventDay =
        DateFormat.d().format(widget.resource.time.toDate().toLocal());
    var today = DateTime.now().day.toString();

    var convertedTime =
        DateTime.parse(widget.resource.time.toDate().toString()).toString();
    var time = timeFormat(convertedTime.substring(11, 16));

    if (eventDay == widget.day || eventDay == today) {
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
            title: Text(
              widget?.resource?.name ?? '',
              style: TextStyle(
                color: isExpanded
                    ? Colors.white
                    : (_brightnessValue == Brightness.light
                        ? Color(0xFF1E90FF)
                        : Colors.white),
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                  bottom: 15.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Local: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            width: _width * 0.8,
                            child: Text(
                              widget.resource.local,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Descrição: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            width: _width * 0.8,
                            child: Text(
                              widget.resource.description,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Palestrante(s): ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            width: _width * 0.8,
                            child: Text(
                              widget.resource.speakers[0] +
                                  ', ' +
                                  widget.resource.speakers[1],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PinchZoomImage(
                      image: Image.asset('assets/map/' +
                          widget.resource.mapImageName +
                          '.png'),
                      zoomedBackgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
                      hideStatusBarWhileZooming: false,
                    ),
                  ],
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

class ActivitiesForDay extends StatelessWidget {
  final String day;

  ActivitiesForDay({
    Key key,
    @required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activity>>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(15.0),
          itemCount: activities == null ? 1 : activities.length,
          itemBuilder: (BuildContext context, int index) {
            return ActivityCard(
              resource: activities[index],
              day: this.day,
            );
          },
        ),
      ),
    );
  }
}
