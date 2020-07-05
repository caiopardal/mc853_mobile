import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flare_flutter/flare_actor.dart';

class SpeakersList extends StatefulWidget {
  @override
  _SpeakersListState createState() => _SpeakersListState();
}

class _SpeakersListState extends State<SpeakersList> {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  Widget socialActions(context, Speaker speaker) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.facebookURL);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.linkedinURL);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.githubURL);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    final speakers = Provider.of<List<Speaker>>(context);

    if (speakers == null) {
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
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: speakers.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        child: Image(
                          image: AssetImage('assets/pardal.jpg'),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  speakers[index].name,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height: 5,
                                  color: Colors.lightBlue,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              speakers[index].description,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              speakers[index].activity,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            socialActions(context, speakers[index]),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
