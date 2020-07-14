import 'package:flutter/material.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/widgets/speaker_item.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

class SpeakersList extends StatefulWidget {
  @override
  _SpeakersListState createState() => _SpeakersListState();
}

class _SpeakersListState extends State<SpeakersList> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    final speakers = Provider.of<List<Speaker>>(context);
    print(speakers);

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
                return SpeakerItem(
                  speaker: speakers[index],
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
