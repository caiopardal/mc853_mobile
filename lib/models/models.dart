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
