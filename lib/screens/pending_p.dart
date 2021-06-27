import 'package:flutter/material.dart';

class pendingAppointments extends StatefulWidget {
  _pendingAppointments createState() => _pendingAppointments();
}

class Appointment {
  String date;
  String time;
  String user;

  Appointment(this.date, this.time, this.user);
}

class _pendingAppointments extends State<pendingAppointments> {
  @override
  List<Appointment> appointments = [
    Appointment("July 1", "11 AM", "Ahmad Traboulsi"),
    Appointment("July 1", "11:30 AM", "Hadi Hassan")
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: appointments.length,
            itemBuilder: (context, int index) {
              return Container(
                height: 150.0,
                width: 100.0,
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
                              child: Text(
                                appointments[index].user,
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
                              child: Text(
                                appointments[index].date,
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
                              child: Text(
                                appointments[index].time,
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              child: Text("Accept",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent)),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.orange.shade50)),
                              onPressed: () => print(""),
                            ),
                            Container(
                              width: 20,
                            ),
                            ElevatedButton(
                              child: Text("Reject",
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent)),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.orange.shade50)),
                              onPressed: () => print(""),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  color: Colors.orange.shade100,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  semanticContainer: true,
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
