import 'package:flutter/material.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/my_activities_list.dart';

class MyActivities extends StatefulWidget {
  final String day;
  final String uid;

  MyActivities({
    Key key,
    @required this.day,
    @required this.uid,
  }) : super(key: key);

  @override
  _MyActivitiesState createState() => _MyActivitiesState();
}

class _MyActivitiesState extends State<MyActivities> {
  bool loading = false;
  List<Speaker> speakers;

  @override
  void initState() {
    DatabaseService.getSpeakers().then((value) {
      setState(() {
        speakers = value;
        loading = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: _height,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: MyActivitiesList(
                  day: '',
                  uid: widget.uid,
                  speakers: speakers,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
