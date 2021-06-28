import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fistbump/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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

  getProfile(String email) async {
    return _firestore
        .collection('users')
        .where("email", isEqualTo: email)
        .get();
  }

  Future<void> insertUser(String email, String user) {
    return _firestore
        .collection('users')
        .add({'email': email, 'professional': false, 'name': user});
  }

  void addPending(String id, List appointment) {
    try {
      Map appt_u() {
        return {
          "name": appointment[0],
          "time": appointment[1],
          "user_email": appointment[2],
          "Professional": appointment[3]
        };
      }
      Map appt_p() {
        return {
          "name": appointment[0],
          "time": appointment[1],
          "user_email": appointment[2],
        };
      }

      _firestore.collection('profiles').doc(id).update({
        "pending_appointments": FieldValue.arrayUnion([appt_p()])
      });
      _firestore
          .collection('users')
          .where('email', isEqualTo: appointment[2])
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((documentSnapshot) {
          documentSnapshot.reference.update({
            "pending_appointments": FieldValue.arrayUnion([appt_u()])
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void acceptPending(String id, List appointment) {
    try {
      Map appt_u() {
        return {
          "name": appointment[0],
          "time": appointment[1],
          "user_email": appointment[2],
          "Professional": appointment[3]
        };
      }
      Map appt_p() {
        return {
          "name": appointment[0],
          "time": appointment[1],
          "user_email": appointment[2],
        };
      }

      // profiles collection: remove from pending and add to accepted appointments
      _firestore.collection('profiles').doc(id).update({
        "pending_appointments": FieldValue.arrayRemove([appt_p()])
      });

      _firestore.collection('profiles').doc(id).update({
        "appointments": FieldValue.arrayUnion([appt_p()])
      });
      // users collection: remove from pending and add to accepted appointments
      _firestore
          .collection('users')
          .where('email', isEqualTo: appointment[2])
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((documentSnapshot) {
          documentSnapshot.reference.update({
            "pending_appointments": FieldValue.arrayRemove([appt_u()])
          });
        });
      });

      _firestore
          .collection('users')
          .where('email', isEqualTo: appointment[2])
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((documentSnapshot) {
          documentSnapshot.reference.update({
            "appointments": FieldValue.arrayUnion([appt_u()])
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }
}

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;

//  currentUser() async {
//    try {
//      await Future.delayed(Duration(milliseconds: 500));
//      User user = auth.currentUser;
//      String email = user.email;
//      return email;
//    } catch (e) {
//      return "";
//    }
//  }

  dynamic register(email, pass) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  dynamic signIn(email, pass) async {
    try {
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return "Enter a valid password";
        case "user-not-found":
          return "No account exists with this email.";
        case "invalid-email":
          return "Email address is badly formatted.";
      }
      return e.message;
    }
  }

  signOut() async {
    await auth.signOut();
  }
}

String user_name = "";
String user_email = "";
List pending_appts = [];
List accepted_appts = [];

String earliestAppt(List t) {

  var earliest = t[0]["time"].toDate();
  for (int i = 1; i < t.length; i++) {
    if(t[i]["time"].toDate().isBefore(earliest))
      {
        earliest = t[i]["time"].toDate();
      }
  }
  return earliest.toString();
}
