import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/helpers/utils.dart';
import 'package:inscritus/models/activity.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

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
          color: (isExpanded) ? Color(0xFFE1F5FE) : Color(0xFF97DCFC),
          child: ExpansionTile(
            onExpansionChanged: (bool expanding) =>
                setState(() => this.isExpanded = expanding),
            leading: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 6.0,
                    bottom: 6.0,
                  ),
                  child: Icon(
                    GroovinMaterialIcons.calendar_clock,
                    size: 24.0,
                    color: isExpanded
                        ? Theme.of(context).primaryColorDark
                        : Colors.black,
                  ),
                ),
                new Text(
                  time ?? '',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: isExpanded
                        ? (_brightnessValue == Brightness.light
                            ? Color(0xFF1E90FF)
                            : Colors.white)
                        : Colors.black,
                    textBaseline: TextBaseline.alphabetic,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              isExpanded ? Icons.star_border : Icons.star,
              color: isExpanded
                  ? Theme.of(context).primaryColorDark
                  : (_brightnessValue == Brightness.light
                      ? Colors.black
                      : Theme.of(context).primaryColorDark),
              size: 30.0,
            ),
            title: Text(
              widget?.resource?.name ?? '',
              style: TextStyle(
                color: isExpanded
                    ? Theme.of(context).primaryColorDark
                    : (_brightnessValue == Brightness.light
                        ? Colors.black
                        : Theme.of(context).primaryColorDark),
                fontSize: 16.0,
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
                              color: Theme.of(context).primaryColorDark,
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
                              color: Theme.of(context).primaryColorDark,
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
                              color: Theme.of(context).primaryColorDark,
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

    if (activities == null) {
      return Center(
        child: Container(
          color: Colors.transparent,
          height: 400.0,
          width: 400.0,
          child: FlareActor(
            'assets/flare/loading_indicator.flr',
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "idle",
          ),
        ),
      );
    }

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
