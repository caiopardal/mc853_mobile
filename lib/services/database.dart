import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/activity_type.dart';
import 'package:inscritus/models/announcement.dart';
import 'package:inscritus/models/location.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  final CollectionReference speakersCollection =
      Firestore.instance.collection('speakers');

  final CollectionReference feedCollection =
      Firestore.instance.collection('feed');

  final CollectionReference activitiesCollection =
      Firestore.instance.collection('activities');

  final CollectionReference activityTypesCollection =
      Firestore.instance.collection('activity-types');

  final CollectionReference locationsCollection =
      Firestore.instance.collection('locations');

  // speakers list from snapshot
  List<Speaker> _speakerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Speaker(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        activities: List.from(doc.data['activities']) ?? '',
        bio: doc.data['bio'] ?? '',
        shortBio: doc.data['shortBio'] ?? '',
        imageURL: doc.data['imageUrl'] ?? '',
        social: Map<String, String>.from(doc.data['social']) ?? '',
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
      return Announcement(
        message: doc.data['message'] ?? '',
        title: doc.data['title'] ?? '',
        id: doc.data['id'] ?? '',
        postedAt: doc.data['postedAt'] ?? '',
        lastUpdate: doc.data['lastUpdate'] ?? '',
        publisher: Map<String, String>.from(doc.data['publisher']) ?? '',
      );
    }).toList();
  }

  // get announcements stream
  Stream<List<Announcement>> get announcements {
    return feedCollection
        .orderBy("lastUpdate", descending: true)
        .snapshots()
        .map(_announcementListFromSnapshot);
  }

  // activities list from snapshot
  List<Activity> _activitiesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Activity(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        lastUpdate: doc.data['lastUpdate'] ?? '',
        maxCapacity: doc.data['maxCapacity'] ?? null,
        preRegistration: doc.data['preRegistration'] ?? false,
        startDate: doc.data['startDate'] ?? '',
        startTime: doc.data['startTime'] ?? '',
        type: doc.data['type'] ?? '',
        visible: doc.data['visible'] ?? true,
        description: doc.data['description'] ?? '',
        speakers: List.from(doc.data['speakers']) ?? '',
        confirmations: List.from(doc.data['confirmations']) ?? '',
        location: doc.data['location'] ?? '',
      );
    }).toList();
  }

  // get activities stream
  Stream<List<Activity>> get activities {
    return activitiesCollection.snapshots().map(_activitiesListFromSnapshot);
  }

  // users list from snapshot
  List<User> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        name: doc.data['name'] ?? '',
        uid: doc.data['uid'] ?? '',
        cpf: doc.data['cpf'] ?? '',
        email: doc.data['email'] ?? '',
        phone: doc.data['phone'] ?? '',
        createdAt: doc.data['createdAt'] ?? '',
        lastUpdate: doc.data['lastUpdate'] ?? '',
        isActive: doc.data['isActive'] ?? false,
        isAdmin: doc.data['isAdmin'] ?? false,
        emailVerified: doc.data['emailVerified'] ?? false,
      );
    }).toList();
  }

  // get users stream
  Stream<List<User>> get users {
    return usersCollection.snapshots().map(_usersListFromSnapshot);
  }

  // activity-types list from snapshot
  List<ActivityType> _activityTypesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ActivityType(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        description: doc.data['bio'] ?? '',
      );
    }).toList();
  }

  // get activity-types stream
  Stream<List<ActivityType>> get activityTypes {
    return activityTypesCollection
        .snapshots()
        .map(_activityTypesListFromSnapshot);
  }

  // locations list from snapshot
  List<Location> _locationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Location(
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
        description: doc.data['description'] ?? '',
        imageUrl: doc.data['imageUrl'] ?? '',
        mapsUrl: doc.data['mapsUrl'] ?? '',
        mapsLink: doc.data['mapsLink'] ?? '',
      );
    }).toList();
  }

  // get locations stream
  Stream<List<Location>> get locations {
    return locationsCollection.snapshots().map(_locationListFromSnapshot);
  }

  static Future<bool> checkIfEmailIsAlreadyConfirmed(
      String docID, String email) async {
    bool exists = false;
    try {
      await Firestore.instance.document("activities/$docID").get().then((doc) {
        if (doc.data['confirmations'] != null) {
          var confirmedList = List.from(doc.data['confirmations']);

          if (confirmedList.contains(email)) {
            exists = true;
          } else {
            exists = false;
          }
        }
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<void> confirmAnEmailToActivity(
      String docID, String email) async {
    List emails = [];
    emails.add(email);
    try {
      await Firestore.instance
          .document("activities/$docID")
          .updateData({"confirmations": FieldValue.arrayUnion(emails)});
    } catch (e) {
      return false;
    }
  }

  static Future<void> favoriteActivity(
    String uid,
    String activityId,
  ) async {
    List activities = [];
    activities.add(activityId);
    try {
      await Firestore.instance
          .document("users/$uid")
          .updateData({"activities": FieldValue.arrayUnion(activities)});
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkIfActivityIsAlreadyFavorited(
      String uid, String activityId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$uid").get().then((doc) {
        if (doc.data['activities'] != null) {
          var confirmedList = List.from(doc.data['activities']);

          if (confirmedList.contains(activityId)) {
            exists = true;
          } else {
            exists = false;
          }
        }
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<void> removeActivityFromFavorites(
      String uid, String activityId) async {
    try {
      await Firestore.instance.document("users/$uid").get().then((doc) async {
        if (doc.data['activities'] != null) {
          var confirmedList = List.from(doc.data['activities']);

          if (confirmedList.contains(activityId)) {
            List activities = [];
            activities.add(activityId);
            try {
              await Firestore.instance.document("users/$uid").updateData(
                  {"activities": FieldValue.arrayRemove(activities)});
            } catch (e) {
              return false;
            }
          }
        }
        return true;
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Activity>> getActivitiesByIds(List<String> docsIDs) async {
    try {
      List<Activity> activities = [];
      docsIDs.forEach((id) async {
        var activity = await getActivityById(id);
        activities.add(activity);
      });
      return activities;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Activity> getActivityById(String docID) async {
    try {
      Activity activity;

      await Firestore.instance.document("activities/$docID").get().then((doc) {
        activity = Activity(
          name: doc.data['name'] ?? '',
          id: doc.data['id'] ?? '',
          lastUpdate: doc.data['lastUpdate'] ?? '',
          maxCapacity: doc.data['maxCapacity'] ?? null,
          preRegistration: doc.data['preRegistration'] ?? false,
          startDate: doc.data['startDate'] ?? '',
          startTime: doc.data['startTime'] ?? '',
          type: doc.data['type'] ?? '',
          visible: doc.data['visible'] ?? true,
          description: doc.data['description'] ?? '',
          speakers: List.from(doc.data['speakers']) ?? '',
          confirmations: List.from(doc.data['confirmations']) ?? '',
          location: doc.data['location'] ?? '',
        );
      });

      return activity;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<User> getUserById(String docID) async {
    try {
      User user;

      await Firestore.instance.document("users/$docID").get().then((doc) {
        user = User(
          name: doc.data['name'] ?? '',
          uid: doc.data['uid'] ?? '',
          cpf: doc.data['cpf'] ?? '',
          email: doc.data['email'] ?? '',
          phone: doc.data['phone'] ?? '',
          createdAt: doc.data['createdAt'] ?? '',
          lastUpdate: doc.data['lastUpdate'] ?? '',
          isActive: doc.data['isActive'] ?? false,
          isAdmin: doc.data['isAdmin'] ?? false,
          emailVerified: doc.data['emailVerified'] ?? false,
        );
      });

      return user;
    } catch (e) {
      return null;
    }
  }

  static Future<Location> getLocationById(String docID) async {
    try {
      Location location;

      await Firestore.instance.document("locations/$docID").get().then((doc) {
        location = Location(
          name: doc.data['name'] ?? '',
          id: doc.data['id'] ?? '',
          description: doc.data['description'] ?? '',
          imageUrl: doc.data['imageUrl'] ?? '',
          mapsUrl: doc.data['mapsUrl'] ?? '',
          mapsLink: doc.data['mapsLink'] ?? '',
        );
      });

      return location;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Speaker>> getSpeakers() async {
    try {
      List<Speaker> speakers = [];
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("speakers").getDocuments();
      for (int i = 0; i < querySnapshot.documents.length; i++) {
        var doc = querySnapshot.documents[i];
        Speaker speaker = Speaker(
          name: doc.data['name'] ?? '',
          id: doc.data['id'] ?? '',
          activities: List.from(doc.data['activities']) ?? '',
          bio: doc.data['bio'] ?? '',
          shortBio: doc.data['shortBio'] ?? '',
          imageURL: doc.data['imageUrl'] ?? '',
          social: Map<String, String>.from(doc.data['social']) ?? '',
        );

        speakers.add(speaker);
      }

      return speakers;
    } catch (e) {
      return null;
    }
  }

  static Future<List<String>> getUserActivitiesIds(String docID) async {
    try {
      List<String> ids = [];

      await Firestore.instance.document("users/$docID").get().then((doc) async {
        if (doc.data['activities'] != null) {
          var confirmedList = List.from(doc.data['activities']);

          for (int i = 0; i < confirmedList.length; i++) {
            ids.add(confirmedList[i]);
          }
        }
      });
      return ids;
    } catch (e) {
      return null;
    }
  }

  static Future<void> registerNewUser(
    String email,
    String cpf,
    String name,
    String phone,
    String uid,
  ) async {
    Timestamp now = Timestamp.now();

    try {
      await Firestore.instance.document("users/$uid").setData({
        "uid": uid,
        "cpf": cpf,
        "name": name,
        "phone": phone,
        "email": email,
        "isActive": true,
        "isAdmin": false,
        "emailVerified": false,
        "createdAt": now,
        "lastUpdate": now,
      });
    } catch (e) {
      return false;
    }
  }
}
