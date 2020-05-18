import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

/// Announcement Resource
///
/// @param text announcement description
/// @param ts time stamp when an announcement was made

class Announcement {
  final String text;
  final String ts;

  Announcement({this.text, this.ts});

  @override
  String toString() {
    return '{"text": ${json.encode(this.text)}' +
        ',"ts": ${json.encode(this.ts)}}';
  }

  Announcement.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        ts = json['ts'];
}

/// Day-Of Event Resource
///
/// @param summary event name
/// @param location event location which can be used to fetch event map
/// @param start event time

class Event {
  final String summary;
  final String location;
  final DateTime start;

  Event({this.summary, this.location, this.start});

  Event.fromJson(Map<String, dynamic> json)
      : summary = json['summary'],
        location = json['location'],
        start = DateTime.parse(json['start']['dateTime']);
}
