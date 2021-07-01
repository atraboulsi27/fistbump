import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:fistbump/repository/profile_repository.dart';


class Calendar extends StatefulWidget{
  _Calendar createState() => _Calendar();

}


// getdata1 and getdata 2 retrieve pending and accepted appointments (each alone
// so it can have different colors in the calendar), and then get returned by
// getdata all, appointment details should get filled with a selected appointment
// but the calendar onselection does not work with filled appointment entries.
// The for loop finds the appointment in all_appointments so it can fill its
// data from there.

class _Calendar extends State<Calendar> {
  @override

  CalendarSelectionDetails currentSelection =
  CalendarSelectionDetails(DateTime.now(), null);
  final ProfileRepository repository = ProfileRepository();



  List<Appointment> _getDataSource1() {
    final List<Appointment> appointments = <Appointment>[];
    accepted_appts.forEach((element) {
      final DateTime startTime = element["time"].toDate();
      final DateTime endTime = element["time"].toDate().add(const Duration(hours: 1));
      appointments.add(Appointment(
          startTime: startTime, endTime: endTime, color: Colors.deepOrange));
    });
    return appointments;

  }

  List<Appointment> _getDataSource2() {
    final List<Appointment> appointments = <Appointment>[];
    pending_appts.forEach((element) {
      final DateTime startTime = element["time"].toDate();
      final DateTime endTime = element["time"].toDate().add(const Duration(hours: 1));
      appointments.add(Appointment(
          startTime: startTime, endTime: endTime, color: Colors.orange));
    });
    return appointments;
  }

  List all_appointments = pending_appts + accepted_appts;
  List<Appointment> _getDataSource_all() {
    List<Appointment> all = [];
    all = _getDataSource1() + _getDataSource2();

    return all;
  }

  String appointment_details ="";

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SfCalendar(view: CalendarView.workWeek,
            onSelectionChanged: (CalendarSelectionDetails details) {
              setState(() {
                currentSelection = details;
                print(details.date.toString());
//                for(int i = 0; i < all_appointments.length;i++)
//                  {
//                    if(currentSelection.date.toString() == all_appointments[i]["time"].toDate)
//                      {
//                          appointment_details = all_appointments[i]["time"].toDate().toString();
//                      }
//                  }
              });
            },
            firstDayOfWeek: 1,
            timeSlotViewSettings: TimeSlotViewSettings(
              startHour: 9,
              endHour: 18,
              nonWorkingDays: [DateTime.saturday, DateTime.sunday],
            ),
            dataSource: AppointmentDataSource(_getDataSource_all()),
            showDatePickerButton: true,
          ),
          Text(appointment_details)
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