import 'package:flutter/material.dart';
import 'package:fistbump/repository/profile_repository.dart';
import 'package:fistbump/email.dart';

class pendingAppointments extends StatefulWidget {
  _pendingAppointments createState() => _pendingAppointments();
}

class _pendingAppointments extends State<pendingAppointments> {
  final ProfileRepository repo = ProfileRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pending_appts.length,
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
                                pending_appts[index]["name"],
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
                              child: Text(
                                pending_appts[index]["time"]
                                    .toDate()
                                    .toString(),
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ),
//                            Padding(
//                              padding: const EdgeInsets.fromLTRB(13, 10, 0, 0),
//                              child: Text(
//                                pending_appts[index]["user_email"],
//                                style: TextStyle(color: Colors.deepOrange),
//                              ),
//                            ),
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
                              onPressed: () {
                                List appointment = [
                                  pending_appts[index]["name"],
                                  pending_appts[index]["time"],
                                  pending_appts[index]["user_email"],
                                  pending_appts[index]["Professional"]
                                ];
                                repo.acceptPending(doc_id, appointment);
                                sendEmail(
                                    pending_appts[index]["user_email"],
                                    user_name,
                                    pending_appts[index]["name"],
                                    pending_appts[index]["time"].toDate(),
                                    false,
                                    true);
                                setState(() {
                                  pending_appts.removeAt(index);
                                });

                              },
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
                              onPressed: () {
                                List appointment = [
                                  pending_appts[index]["name"],
                                  pending_appts[index]["time"],
                                  pending_appts[index]["user_email"],
                                  pending_appts[index]["Professional"]
                                ];
                                repo.rejectPending(doc_id, appointment);
                                sendEmail(
                                    pending_appts[index]["user_email"],
                                    user_name,
                                    pending_appts[index]["name"],
                                    pending_appts[index]["time"],
                                    false,
                                    false);
                                setState(() {
                                  pending_appts.removeAt(index);
                                });

                              },
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
