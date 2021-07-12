import 'package:flutter/material.dart';
import 'package:fistbump/repository/profile_repository.dart';
import 'package:flutter/services.dart';
import 'home.dart';

class EditProfilePage extends StatefulWidget {
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  @override
  final ProfileRepository repository = ProfileRepository();
  String _chosenValue = user_sex;
  TextEditingController ageController = TextEditingController(text: user_age);
  TextEditingController nameController = TextEditingController(text: user_name);


  Widget _submitButton() {
    return InkWell(
      onTap: () {
        user_age = ageController.text;
        user_sex = _chosenValue;
        user_name = nameController.text.trim();
        repository.updateUserProfile(user_email, user_sex, user_age, user_name);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Home()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width/2,
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
        text: 'Edit Personal Information',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w700,
          color: Colors.deepOrangeAccent,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            _title(),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(width: 80),
                Container(
                  child: Text(
                    "Full Name",
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  width: 170,
//                  height: 50,
                  child: TextField(
                    controller: nameController,
                    decoration:
                        InputDecoration(fillColor: Colors.orange, filled: true),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              SizedBox(width: 80),
              Container(
                child: Text(
                  "Sex",
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              ),
              SizedBox(width: 70),
              DropdownButton<String>(
                onChanged: (String? value) {
                  setState(() {
                    _chosenValue = value!;
                  });
                },
                dropdownColor: Colors.deepOrange.shade50,
                value: _chosenValue,
                elevation: 16,
                style: TextStyle(color: Colors.deepOrangeAccent),
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ]),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(width: 80),
                Container(
                  child: Text(
                    "Age",
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),
                ),
                SizedBox(width: 70),
                Container(
                  width: 70,
//                  height: 50,
                  child: TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(fillColor: Colors.orange, filled: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(2),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    "years",
                    style: TextStyle(color: Colors.deepOrangeAccent),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            _submitButton()
          ],
        ),
      ),
    );
  }
}
