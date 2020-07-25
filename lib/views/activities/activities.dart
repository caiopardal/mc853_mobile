import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/activities_for_day.dart';
import 'package:provider/provider.dart';

class Activities extends StatefulWidget {
  final String uid;

  Activities({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  ActivitiesState createState() => ActivitiesState();
}

class ActivitiesState extends State<Activities>
    with SingleTickerProviderStateMixin {
  TabController controller;
  List<Speaker> speakers;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);

    DatabaseService.getSpeakers().then((value) {
      setState(() {
        speakers = value;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      tabs: <Tab>[
        Tab(text: 'Sábado'),
        Tab(text: 'Domingo'),
      ],
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xFF97DCFC),
      ),
      indicatorWeight: 2.0,
      indicatorSize: TabBarIndicatorSize.tab,
      controller: controller,
      unselectedLabelColor: Colors.black,
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17.0,
      ),
    );
  }

  TabBarView getTabBarView(var tabs) {
    return new TabBarView(children: tabs, controller: controller);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Activity>>.value(
      value: DatabaseService().activities,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: getTabBar(),
          backgroundColor: Color(0xFFE1F5FE),
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: getTabBarView(<Widget>[
          ActivitiesForDay(
            day: '28',
            speakers: speakers,
            uid: widget.uid,
          ),
          ActivitiesForDay(
            day: '29',
            speakers: speakers,
            uid: widget.uid,
          ),
        ]),
      ),
    );
  }
}
