import 'package:flutter/material.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/views/speakers/speakers_list.dart';
import 'package:provider/provider.dart';

class SpeakersView extends StatefulWidget {
  @override
  _SpeakersViewState createState() => _SpeakersViewState();
}

class _SpeakersViewState extends State<SpeakersView> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Speaker>>.value(
      value: DatabaseService().speakers,
      child: Scaffold(
        body: SpeakersList(),
      ),
    );
  }
}
