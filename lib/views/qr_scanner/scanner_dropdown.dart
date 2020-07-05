import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:provider/provider.dart';

class ScannerDropdown extends StatefulWidget {
  final Function onChange;
  final String selectedLocation;

  ScannerDropdown({
    this.onChange,
    this.selectedLocation,
  });

  @override
  _ScannerDropdownState createState() => _ScannerDropdownState();
}

class _ScannerDropdownState extends State<ScannerDropdown> {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activity>>(context);

    if (activities == null) {
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

    return Center(
      child: DropdownButton(
        hint: Text('Selecione uma atividade'), // Not necessary for Option 1
        value: widget.selectedLocation,
        onChanged: (newValue) {
          widget.onChange(newValue);
        },
        items: activities.map((activity) {
          return DropdownMenuItem(
            child: new Text(activity.name),
            value: activity.name,
          );
        }).toList(),
      ),
    );
  }
}
