import 'package:flutter/material.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:inscritus/helpers/utils.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/widgets/activity_detail.dart';
import 'package:intl/intl.dart';
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
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        isExpanded ? Icons.star_border : Icons.star,
                        color: Theme.of(context).primaryColorDark,
                        size: 30.0,
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

class ActivitiesForDay extends StatelessWidget {
  final String day;
  final List<Speaker> speakers;

  ActivitiesForDay({
    Key key,
    @required this.day,
    @required this.speakers,
  }) : super(key: key);

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
            return GestureDetector(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                      activity: activities[index],
                      speakers: filterSpeakers(speakers, activities[index]),
                    ),
                  ),
                );
              },
              child: ActivityCard(
                resource: activities[index],
                day: this.day,
              ),
            );
          },
        ),
      ),
    );
  }
}
