import 'package:fistbump/repository/profile_repository.dart';
import 'package:fistbump/screens/list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileRepository repository = ProfileRepository();

  void _navigateToTrainers() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ListPage(callback: repository.getTrainers)));
  }

  void _navigateToDietitians() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ListPage(callback: repository.getDietitians)));
  }

  void _navigateToMealPlanners() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ListPage(callback: repository.getMealPlanners)));
  }

  void _navigateToPhysiotherapists() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ListPage(callback: repository.getPhysiotherapists)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Upcoming appointments",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "No upcoming Appointments",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(children: [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: Text(
                "Explore",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ]),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: _navigateToDietitians,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber[800]),
                        child: Column(
                          children: [
                            Text(
                              "Dietitians",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.restaurant_menu_outlined,
                              color: Colors.white,
                              size: 75,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: _navigateToTrainers,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber[800]),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "Trainers",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Icon(
                                  Icons.sports_mma_outlined,
                                  color: Colors.white,
                                  size: 75,
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                        ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: _navigateToMealPlanners,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber[800]),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Meal Plans",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Icon(
                                Icons.restaurant,
                                color: Colors.white,
                                size: 75,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _navigateToPhysiotherapists,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber[800]),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Physiotherapists",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Icon(
                                Icons.medical_services_outlined,
                                color: Colors.white,
                                size: 75,
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
