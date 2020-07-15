import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/activities_for_day.dart';
import 'package:inscritus/widgets/activity_detail.dart';

class MyActivities extends StatefulWidget {
  final String uid;
  final String day;
  final List<Speaker> speakers;

  MyActivities({
    Key key,
    @required this.uid,
    @required this.day,
    @required this.speakers,
  }) : super(key: key);

  @override
  _MyActivitiesState createState() => _MyActivitiesState();
}

class _MyActivitiesState extends State<MyActivities> {
  List<Activity> activities;

  @override
  void initState() {
    DatabaseService.getUserActivitiesIds(widget.uid).then((value) {
      DatabaseService.getActivitiesByIds(value).then((newActivities) {
        setState(() {
          activities = newActivities;
        });
      });
    });

    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
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
            return GestureDetector(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                      activity: activities[index],
                      speakers:
                          filterSpeakers(widget.speakers, activities[index]),
                    ),
                  ),
                );
              },
              child: ActivityCard(
                resource: activities[index],
                day: this.widget.day,
                isFavoritesScreen: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
