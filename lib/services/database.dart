import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inscritus/models/announcement.dart';
import 'package:inscritus/models/speaker.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  static final CollectionReference eventsCollection =
      Firestore.instance.collection('events');
  final CollectionReference speakersCollection =
      eventsCollection.document('1j2gFffXiROT5NLe0G5O').collection('speakers');
  final CollectionReference announcementsCollection = eventsCollection
      .document('1j2gFffXiROT5NLe0G5O')
      .collection('announcements');

  // speakers list from snapshot
  List<Speaker> _speakerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Speaker(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        activity: doc.data['activity'] ?? '',
        description: doc.data['description'] ?? '',
        imageURL: doc.data['imageURL'] ?? '',
        facebookURL: doc.data['facebookURL'] ?? '',
        githubURL: doc.data['githubURL'] ?? '',
        linkedinURL: doc.data['linkedinURL'] ?? '',
      );
    }).toList();
  }

  // get speakers stream
  Stream<List<Speaker>> get speakers {
    return speakersCollection.snapshots().map(_speakerListFromSnapshot);
  }

  // announcement list from snapshot
  List<Announcement> _announcementListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Announcement(
        text: doc.data['text'] ?? '',
        id: doc.data['id'] ?? '',
        createdAt: doc.data['createdAt'] ?? '',
      );
    }).toList();
  }

  // get announcements stream
  Stream<List<Announcement>> get announcements {
    return announcementsCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(_announcementListFromSnapshot);
  }
}
