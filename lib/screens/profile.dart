import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fistbump/repository/profile_repository.dart';
import 'edit_userprofile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  final ProfileRepository repository = ProfileRepository();

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
          repository.insertPhotoUrl(user_email, imageUrl);
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditProfilePage()));
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                          child: Image.network(user_photo)),
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
                  child: Text(
                    user_name,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
                  child: Text(
                    "Age: " + user_age + " years old",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
                  child: Text(
                    "Sex: " + user_sex,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_editButton()],
            ),
          ],
        ),
      ),
    );
  }
}
