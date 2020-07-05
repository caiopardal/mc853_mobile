import 'package:flutter/material.dart';
import 'package:inscritus/models/models.dart';
import 'package:inscritus/views/dashboard/announcement_card.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var announcements = {
      "text": "Follow us on social medias",
      "ts": "1571908519.113700",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(
                  20.0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Text(
                  'Anúncios',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: _height,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: 25.0,
                          ),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return AnnouncementCard(
                                resource: Announcement.fromJson(announcements));
                          },
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
