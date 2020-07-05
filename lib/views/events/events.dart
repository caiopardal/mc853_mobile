import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/events_for_day.dart';
import 'package:provider/provider.dart';

class Events extends StatefulWidget {
  @override
  EventsState createState() => EventsState();
}

class EventsState extends State<Events> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
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
        color: Theme.of(context).accentColor,
      ),
      indicatorWeight: 2.0,
      indicatorSize: TabBarIndicatorSize.tab,
      controller: controller,
      unselectedLabelColor:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Color(0xFF1E90FF)
              : Colors.white,
      labelColor: Colors.black,
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
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
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
        ),
        body: getTabBarView(<Widget>[
          EventsForDay(
            day: '5',
          ),
          EventsForDay(
            day: '6',
          ),
        ]),
      ),
    );
  }
}
