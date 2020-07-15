import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeakerItem extends StatelessWidget {
  final Speaker speaker;

  SpeakerItem({
    @required this.speaker,
  });

  Widget socialActions(context, Speaker speaker) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (speaker.social['facebook'] != null &&
                speaker.social['facebook'] != '')
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebookF,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker.social['facebook']);
                },
              ),
            if (speaker.social['linkedIn'] != null &&
                speaker.social['linkedIn'] != '')
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.linkedinIn,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker.social['linkedIn']);
                },
              ),
            if (speaker.social['github'] != null &&
                speaker.social['github'] != '')
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.github,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker.social['github']);
                },
              ),
            if (speaker.social['twitter'] != null &&
                speaker.social['twitter'] != '')
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker.social['twitter']);
                },
              ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.35,
            ),
            child: Image.network(
              speaker.imageURL,
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
                    Container(
                      margin: const EdgeInsets.only(
                        top: 12,
                      ),
                      child: Text(
                        speaker.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 5,
                      color: Colors.lightBlue,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  speaker.shortBio,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  speaker.bio.length > 120
                      ? speaker.bio.substring(0, 120) + ' ...'
                      : speaker.bio,
                  style: Theme.of(context).textTheme.caption,
                ),
                if (speaker.social.isNotEmpty) socialActions(context, speaker),
              ],
            ),
          )
        ],
      ),
    );
  }
}
