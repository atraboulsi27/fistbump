import 'package:flutter/material.dart';
import 'package:fistbump/repository/profile_repository.dart';
import 'ProfessionalMenu.dart';
import 'profile_p.dart';

class EditProfessionalProfile extends StatefulWidget {
  _EditProfessionalProfile createState() => _EditProfessionalProfile();
}

class _EditProfessionalProfile extends State<EditProfessionalProfile> {
  @override
  final ProfileRepository repository = ProfileRepository();

  TextEditingController nameController =
      TextEditingController(text: profile.name);
  TextEditingController expertiseController =
      TextEditingController(text: profile.expertise);
  TextEditingController descriptionController =
      TextEditingController(text: profile.description);
  TextEditingController locationController =
      TextEditingController(text: profile.location);
  TextEditingController phoneController =
      TextEditingController(text: profile.phone);

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        repository.updateProfessionalProfile(
            profile.email!,
            nameController.text.trim(),
            expertiseController.text.trim(),
            descriptionController.text.trim(),
            locationController.text.trim(),
          phoneController.text.trim()
            );
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfessionalPage()));
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
          'Save changes',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Edit Professional Information',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.deepOrangeAccent,
        ),
      ),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    var size = MediaQuery.of(context).size.width / 3.5;
    return Padding(
      padding: EdgeInsets.fromLTRB(size, 0, 0, 0),
      child: Column(
        children: [
          SizedBox(width: 80),
          Column(
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Column(
            children: [
              Container(
                width: 170,
                child: TextField(
                  controller: controller,
                  decoration:
                      InputDecoration(fillColor: Colors.orange, filled: true),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 3.8;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _entryField("Full Name", nameController),
        _entryField("Description", descriptionController),
        _entryField("Expertise", expertiseController),
        _entryField("Location", locationController),
        _entryField("Phone", phoneController),
        Padding(
          padding: EdgeInsets.fromLTRB(size, 0, 0, 0),
          child: _submitButton(),
        )
      ],
    ));
  }
}
