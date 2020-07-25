import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/location.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/activities_for_day.dart';
import 'package:inscritus/widgets/activity_detail.dart';
import 'package:shimmer/shimmer.dart';

class MyActivitiesList extends StatefulWidget {
  final String day;
  final String uid;
  final List<Speaker> speakers;

  MyActivitiesList({
    Key key,
    @required this.day,
    @required this.uid,
    @required this.speakers,
  }) : super(key: key);

  @override
  _MyActivitiesListState createState() => _MyActivitiesListState();
}

class _MyActivitiesListState extends State<MyActivitiesList> {
  Location location;
  bool loading = false;
  List<Activity> activities;

  @override
  void initState() {
    DatabaseService.updateActivityStream(widget.uid);

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
    var _height = MediaQuery.of(context).size.height;

    return StreamBuilder<List<Activity>>(
      initialData: DatabaseService.myActivitiesStream.value,
      stream: DatabaseService.myActivitiesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting ||
            snapshot?.data == null) {
          var size = MediaQuery.of(context).size.width;
          return Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: Container(
                        width: size * 0.5,
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: true,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                    ),
                    width: size * 0.3,
                    height: 10,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          );
        } else {
          List<Activity> activities = snapshot.data;
          return Container(
            height: _height,
            child: ListView.builder(
              padding: EdgeInsets.all(15.0),
              itemCount: activities == null ? 1 : activities.length,
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
                    await getLocation(activities[index].location);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ActivityDetail(
                          activity: activities[index],
                          location: location,
                          speakers: filterSpeakers(
                            widget.speakers,
                            activities[index],
                          ),
                          uid: widget.uid,
                        ),
                      ),
                    );
                  },
                  child: ActivityCard(
                    resource: activities[index],
                    day: widget.day,
                    uid: widget.uid,
                    isFavoritesScreen: true,
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
