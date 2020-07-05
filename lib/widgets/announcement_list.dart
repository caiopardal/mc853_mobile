import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/announcement.dart';
import 'package:inscritus/widgets/announcement_card.dart';
import 'package:provider/provider.dart';

class AnnouncementList extends StatefulWidget {
  @override
  AnnouncementListState createState() => new AnnouncementListState();
}

class AnnouncementListState extends State<AnnouncementList> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    final announcements = Provider.of<List<Announcement>>(context);

    if (announcements == null) {
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

    return Container(
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
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                return AnnouncementCard(
                  resource: announcements[index],
                );
              },
            ),
            SizedBox(
              height: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}
