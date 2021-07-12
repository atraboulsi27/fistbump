import 'package:fistbump/models/profile_model.dart';
import 'package:fistbump/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:fistbump/email.dart';

class BookAppointmentPage extends StatefulWidget {
  final Profile profile;
  BookAppointmentPage({Key? key, required this.profile}) : super(key: key);

  @override
  _BookAppointmentPageState createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  CalendarSelectionDetails currentSelection =
      CalendarSelectionDetails(DateTime.now(), null);
  final ProfileRepository repository = ProfileRepository();
  List<Appointment> _getDataSource() {
    final List<Appointment> appointments = <Appointment>[];
    widget.profile.appointments!.forEach((element) {
      final DateTime startTime = element.time!;
      final DateTime endTime = element.time!.add(const Duration(hours: 1));
      appointments.add(Appointment(
          startTime: startTime, endTime: endTime, color: Colors.orange));
    });
    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book an appointment",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SfCalendar(
            view: CalendarView.workWeek,
            onSelectionChanged: (CalendarSelectionDetails details) {
              setState(() {
                currentSelection = details;
              });
            },
            firstDayOfWeek: 1,
            timeSlotViewSettings: TimeSlotViewSettings(
              startHour: 9,
              endHour: 18,
              nonWorkingDays: [DateTime.saturday, DateTime.sunday],
            ),
            dataSource: AppointmentDataSource(_getDataSource()),
            showDatePickerButton: true,
          ),
          SizedBox(
              width: 300,
              height: 40,
              child: ElevatedButton(
                child: Text("Book time slot"),
                onPressed: () {
                  List appointment = [
                    user_name,
                    currentSelection.date!,
                    user_email,
                    widget.profile.name!
                  ];
                  repository.addPending(widget.profile.id!, appointment);
                  sendEmail(widget.profile.email!, user_name, widget.profile.name!,
                  currentSelection.date!, true);
//                  repository.acceptPending(widget.profile.id!, appointment);

                  Navigator.of(context).pop();
                },
              )),
        ],
      ),
    );
  }
}

class AppointmentDataSource extends CalendarDataSource {
  final List<Appointment> appointments;
  AppointmentDataSource(this.appointments);

  @override
  DateTime getStartTime(int index) {
    return appointments[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].endTime;
  }
}
