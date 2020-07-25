import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/helpers/utils.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/location.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/activity_detail.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

class ActivityCard extends StatefulWidget {
  ActivityCard({
    @required this.resource,
    @required this.day,
    @required this.uid,
    this.isFavoritesScreen = false,
  });

  final Activity resource;
  final String day;
  final String uid;
  final bool isFavoritesScreen;

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  bool isFavorite = false;

  @override
  void initState() {
    DatabaseService.checkIfActivityIsAlreadyFavorited(
      widget.uid,
      widget.resource.id,
    ).then((value) {
      setState(() {
        isFavorite = value;
      });
    });

    super.initState();
  }

  Future<bool> onLikeButtonTap(bool isLiked) async {
    if (!isLiked) {
      setState(() {
        isFavorite = true;
      });
      await DatabaseService.favoriteActivity(
        widget.uid,
        widget.resource.id,
      );
    } else {
      setState(() {
        isFavorite = false;
      });

      await DatabaseService.removeActivityFromFavorites(
        widget.uid,
        widget.resource.id,
      );
    }
    return !isLiked;
  }

  Widget build(BuildContext context) {
    var splittedDate = widget.resource.startDate.split('-');
    var eventDay = splittedDate[2];

    var today = DateTime.now().day.toString();
    var time = timeFormat(widget.resource.startTime);

    if (eventDay == widget.day ||
        eventDay == today ||
        widget.isFavoritesScreen) {
      return Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0.0,
          color: Color(0xFFE1F5FE),
          child: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            12.0,
                          ),
                          child: Icon(
                            GroovinMaterialIcons.calendar_clock,
                            size: 24.0,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        new Text(
                          time ?? '',
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            color: Color(0xFF1E90FF),
                            textBaseline: TextBaseline.alphabetic,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 5,
                        right: 10,
                      ),
                      child: LikeButton(
                        onTap: (bool isLiked) {
                          return onLikeButtonTap(isFavorite);
                        },
                        isLiked: isFavorite,
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.red,
                            size: 30,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 8.0,
                  ),
                  child: Text(
                    widget?.resource?.name ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container();
  }
}

class ActivitiesForDay extends StatefulWidget {
  final String day;
  final String uid;
  final List<Speaker> speakers;

  ActivitiesForDay({
    Key key,
    @required this.day,
    @required this.uid,
    @required this.speakers,
  }) : super(key: key);

  @override
  _ActivitiesForDayState createState() => _ActivitiesForDayState();
}

class _ActivitiesForDayState extends State<ActivitiesForDay> {
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
                      speakers:
                          filterSpeakers(widget.speakers, activities[index]),
                      uid: widget.uid,
                    ),
                  ),
                );
              },
              child: ActivityCard(
                resource: activities[index],
                day: this.widget.day,
                uid: widget.uid,
              ),
            );
          },
        ),
      ),
    );
  }
}
