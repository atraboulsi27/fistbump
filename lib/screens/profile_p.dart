import 'package:flutter/material.dart';
import 'package:fistbump/models/profile_model.dart';
import 'package:fistbump/repository/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'edit_professionalprofile.dart';

var profile = Profile();

class ProfProfile extends StatefulWidget {
  _ProfProfile createState() => _ProfProfile();
}

class _ProfProfile extends State<ProfProfile> {
  @override
  final ProfileRepository repository = ProfileRepository();
  bool loaded = false;

  void uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile? image;
    late String imageUrl;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image!.path);

      if (image != null) {
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/' + user_email)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          user_photo = imageUrl;
          repository.insertProfessionalPhotoUrl(user_email, imageUrl);
          profile.imageLink = imageUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  Widget _editButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditProfessionalProfile()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
//            BoxShadow(
//                color: Colors.grey.shade200,
//                offset: Offset(2, 4),
//                blurRadius: 5,
//                spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.deepOrangeAccent.shade200, Colors.deepOrange])),
        child: Text(
          'Edit',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  getData() async {
    profile = await repository.getProfessionalProfile(user_email);
    setState(() {
      loaded = true;
    });
  }

  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: loaded
          ? Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            height: 120,
                            child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(profile.imageLink ??
                                    "https://i2.wp.com/airlinkflight.org/wp-content/uploads/2019/02/male-placeholder-image.jpeg?ssl=1")),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add,
                            ),
                            iconSize: 25,
                            color: Colors.green,
                            splashColor: Colors.transparent,
                            splashRadius: 0.1,
                            onPressed: () {
                              uploadImage();
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "${user_name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text("Fitness Trainer"),
                            Row(
                              children: <Widget>[
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star_outline),
                                Icon(Icons.star_outline),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
//              SizedBox(
//                  width: 300,
//                  height: 40,
//                  child: ElevatedButton(
//                    child: Text("Book an appointment"),
//                    onPressed: () {
//                      Navigator.of(context).push(MaterialPageRoute(
//                          builder: (context) =>
//                              BookAppointmentPage(profile: profile)));
//                    },
//                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Likes"),
                          Text("3233"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("Comments"),
                          Text("2703"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text("Suggested"),
                          Text("1101"),
                        ],
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      "About",
                    )
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                        width: 300,
                        child: Text(
                          "${profile.description}",
                        ))
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      "${profile.expertise}",
                    )
                  ]),
                  Row(
                    children: <Widget>[
                      Icon(Icons.near_me_outlined),
                      Text("${profile.location}"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.phone_outlined),
                      Text("${profile.phone}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Articles"),
                      Text("View All"),
                    ],
                  ),
                _editButton()],
              ))
          : Container(),
    );
  }
}
