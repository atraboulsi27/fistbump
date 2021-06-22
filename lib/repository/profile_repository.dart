import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fistbump/models/profile_model.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Profile>> getProfiles() {
    return _firestore.collection('profiles').snapshots().map((snapshot) {
      List<Profile> profiles = snapshot.docs.map((doc) {
        Profile profile = Profile.fromJson(doc.data());
        profile.id = doc.id;
        return profile;
      }).toList();
      print(profiles);
      return profiles;
    });
  }

  Stream<List<Profile>> getTrainers() {
    return _firestore
        .collection('profiles')
        .where("role", isEqualTo: "trainer")
        .snapshots()
        .map((snapshot) {
      List<Profile> profiles = snapshot.docs.map((doc) {
        Profile profile = Profile.fromJson(doc.data());
        profile.id = doc.id;
        return profile;
      }).toList();
      print(profiles);
      return profiles;
    });
  }

  Stream<List<Profile>> getDietitians() {
    return _firestore
        .collection('profiles')
        .where("role", isEqualTo: "dietitian")
        .snapshots()
        .map((snapshot) {
      List<Profile> profiles = snapshot.docs.map((doc) {
        Profile profile = Profile.fromJson(doc.data());
        profile.id = doc.id;
        return profile;
      }).toList();
      print(profiles);
      return profiles;
    });
  }

  Stream<List<Profile>> getMealPlanners() {
    return _firestore
        .collection('profiles')
        .where("role", isEqualTo: "meal-planner")
        .snapshots()
        .map((snapshot) {
      List<Profile> profiles = snapshot.docs.map((doc) {
        Profile profile = Profile.fromJson(doc.data());
        profile.id = doc.id;
        return profile;
      }).toList();
      print(profiles);
      return profiles;
    });
  }

  Stream<List<Profile>> getPhysiotherapists() {
    return _firestore
        .collection('profiles')
        .where("role", isEqualTo: "physiotherapist")
        .snapshots()
        .map((snapshot) {
      List<Profile> profiles = snapshot.docs.map((doc) {
        Profile profile = Profile.fromJson(doc.data());
        profile.id = doc.id;
        return profile;
      }).toList();
      print(profiles);
      return profiles;
    });
  }

  void update(String id, DateTime appointment) {
    try {
      _firestore.collection('profiles').doc(id).update({
        "appointments": FieldValue.arrayUnion([appointment])
      });
    } catch (e) {
      print(e);
    }
  }
}
