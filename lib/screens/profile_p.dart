import 'package:flutter/material.dart';
import 'package:fistbump/models/profile_model.dart';
import 'package:fistbump/repository/profile_repository.dart';

class ProfProfile extends StatefulWidget{
  _ProfProfile createState() => _ProfProfile();

}

class _ProfProfile extends State<ProfProfile> {
  @override

  final ProfileRepository repo = ProfileRepository();
  var profile;


  getData() async{
    profile =  await repo.getProfessionalProfile(user_email);

  }
  void initState()  async{
    super.initState();
    await getData();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(profile.imageLink ??
                          "https://i2.wp.com/airlinkflight.org/wp-content/uploads/2019/02/male-placeholder-image.jpeg?ssl=1")),
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
            ],
          )),
    );
  }

}