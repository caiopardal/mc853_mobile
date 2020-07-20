import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/location.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/activities_for_day.dart';
import 'package:inscritus/widgets/activity_detail.dart';

class MyActivities extends StatefulWidget {
  final String day;
  final String uid;
  final List<Speaker> speakers;
  final List<Activity> activities;

  MyActivities({
    Key key,
    @required this.day,
    @required this.uid,
    @required this.speakers,
    @required this.activities,
  }) : super(key: key);

  @override
  _MyActivitiesState createState() => _MyActivitiesState();
}

class _MyActivitiesState extends State<MyActivities> {
  Location location;
  bool loading = false;

  List<Speaker> filterSpeakers(List<Speaker> speakers, Activity activity) {
    List<Speaker> newSpeakers = [];
    bool isACorrectSpeaker = false;
    for (int i = 0; i < speakers.length; i++) {
      for (int j = 0; j < speakers[i].activities.length; j++) {
        if (speakers[i].activities[j] == activity.id) {
          isACorrectSpeaker = true;
        }
      }
      if (isACorrectSpeaker) newSpeakers.add(speakers[i]);
    }

    return newSpeakers;
  }

  Future<Location> getLocation(String locationId) async {
    setState(() {
      loading = true;
    });

    await DatabaseService.getLocationById(locationId).then((value) {
      setState(() {
        location = value;
        loading = false;
      });
    });

    return location;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.activities == null) {
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
          itemCount: widget.activities == null ? 1 : widget.activities.length,
          itemBuilder: (BuildContext context, int index) {
            if (loading) {
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

            return GestureDetector(
              onTap: () async {
                await getLocation(widget.activities[index].location);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                      activity: widget.activities[index],
                      location: location,
                      speakers: filterSpeakers(
                          widget.speakers, widget.activities[index]),
                    ),
                  ),
                );
              },
              child: ActivityCard(
                resource: widget.activities[index],
                day: this.widget.day,
                uid: widget.uid,
                isFavoritesScreen: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
