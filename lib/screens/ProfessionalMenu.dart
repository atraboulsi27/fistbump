import 'package:flutter/material.dart';
import 'pending_p.dart';
import 'profile_p.dart';
import 'Calendar_p.dart';


class ProfessionalPage extends StatefulWidget {
  @override
  _ProfessionalPage createState() => _ProfessionalPage();
}

class _ProfessionalPage extends State<ProfessionalPage> {
  int currentIndex = 0;
  Map<int, Widget> pageMap ={};
  Map<int, String> titleMap = {
    0: "Pending Appointments",
    1: "Schedule",
    2: "Profile"
  };
  late Widget appBarContent, appBarText;
  late TextEditingController appBarController;

  setAppBar() {
    appBarText = Text(
      titleMap[currentIndex]!,
      style: TextStyle(
          letterSpacing: 2,
//          color: HexColor('#46ab2b'),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );

    appBarContent = appBarText;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
      setAppBar();
      appBarController.clear();
    });
  }

  void initState() {
    super.initState();
    appBarController = TextEditingController();
    pageMap = {0: pendingAppointments(), 1: Calendar(), 2: ProfProfile()};
    setAppBar();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrangeAccent),
        centerTitle: true,
        title: appBarContent,
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: pageMap[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrange,
        fixedColor: Colors.white,
        unselectedItemColor: Color(0x60FFFFFF),
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
        },
        items: [
          BottomNavigationBarItem(label: "", icon: Icon(Icons.list)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.calendar_today)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
