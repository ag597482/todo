import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/page75.dart';
import 'package:todo/screens/photos.dart';
import 'package:todo/screens/todo_page.dart';

class TabLayout extends StatefulWidget {
  const TabLayout({super.key});

  @override
  State<TabLayout> createState() => _TabLayoutState();
}

class _TabLayoutState extends State<TabLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences sharedPreference =
                      await SharedPreferences.getInstance();
                  var imagePath = sharedPreference.getString("imagePath");
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplaySavedPictureScreen(
                        imagePath: imagePath,
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.photo_size_select_actual_outlined,
                  color: Colors.white,
                ))
          ],
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(30, 15, 68, 72),
            tabs: [
              Tab(
                icon: Icon(Icons.today_outlined),
                text: "Todo",
              ),
              Tab(icon: Icon(Icons.domain_verification), text: "Completed"),
              Tab(
                icon: Text(
                  "75",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                text: "Day Challange",
              ),
            ],
          ),
          title: const Text('Day Planner'),
          centerTitle: true,
        ),
        body: const TabBarView(
          children: [
            Todo(),
            Icon(Icons.directions_transit),
            Page75(),
          ],
        ),
      ),
    );
  }
}
