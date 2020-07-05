import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/models.dart';
import 'package:inscritus/views/events/events_for_day.dart';

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

  static List<Event> cachedEvents;
  static DateTime cacheTTL = DateTime.now();
  Stream<List<Event>> _getEvents() {
    var newDate = DateTime.now();
    var cachedEvents = [
      Event.fromJson({
        "summary": "Workshop de node js",
        "location": "Saguão Principal",
        "start": {
          "dateTime": newDate.toIso8601String(),
        },
      }),
      Event.fromJson({
        "summary": "Workshop de React js",
        "location": "Saguão Principal",
        "start": {
          "dateTime": newDate.toIso8601String(),
        },
      }),
    ];

    var streamctl = StreamController<List<Event>>();
    streamctl.sink.add(cachedEvents);
    return streamctl.stream;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: new AppBar(
        title: getTabBar(),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<List<Event>>(
        stream: _getEvents(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
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
            default:
              print(snapshot.hasError);
              var events = snapshot.data;
              return getTabBarView(<Widget>[
                EventsForDay(day: '18', events: events),
                EventsForDay(day: '19', events: events),
              ]);
          }
        },
      ),
    );
  }
}
