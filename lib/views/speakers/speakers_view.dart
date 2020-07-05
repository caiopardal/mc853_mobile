import 'package:flutter/material.dart';
import 'package:inscritus/views/speakers/speaker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SpeakersView extends StatefulWidget {
  @override
  _SpeakersViewState createState() => _SpeakersViewState();
}

class _SpeakersViewState extends State<SpeakersView> {
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
                launch(speaker.fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.githubUrl);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;

    List<Speaker> speakers = [
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
      Speaker(
        speakerName: "Caio Pardal",
        speakerImage: "assets/pardal.jpg",
        speakerDesc: "Google Developer Expert, Flutter",
        speakerSession: "Talk: Getting Started With Flutter For Web",
        fbUrl: "https://www.facebook.com/caio.henrique.90663",
        githubUrl: "https://github.com/caiopardal",
        linkedinUrl:
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
      ),
    ];

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
                          image: AssetImage(speakers[index].speakerImage),
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
                                  speakers[index].speakerName,
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
                              speakers[index].speakerDesc,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              speakers[index].speakerSession,
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
