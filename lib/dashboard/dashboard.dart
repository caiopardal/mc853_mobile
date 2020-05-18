import 'package:flutter/material.dart';
import 'package:inscritus/dashboard/announcement_card.dart';
import 'package:inscritus/models/models.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var announcements = {
      "text":
          "Some pictures of winners have been posted to our Facebook! Watch our social media for many more event photos to come! :)",
      "ts": "1571878519.113700"
    };
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: _height,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Announcements',
                style: Theme.of(context).textTheme.subhead,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                // child: Expanded(
                //   child: SizedBox(
                //     height: _height,
                child: new ListView.builder(
                  padding: EdgeInsets.only(
                    bottom: 25.0,
                  ),
                  itemCount: announcements.length,
                  itemBuilder: (context, index) {
                    return AnnouncementCard(
                        resource: Announcement.fromJson(announcements));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
