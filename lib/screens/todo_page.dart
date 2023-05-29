import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getTasksList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  ListView getTasksList() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                // backgroundColor: getPriorityColor(notelist![position].priority),
                // child: getPriorityIcon((notelist![position].priority)),
              ),
              // title: Text(
              //   notelist![position].title,
              //   style: textStyle,
              // ),
              // subtitle: Text(notelist![position].date),
              trailing: GestureDetector(
                child: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  
                },
              ),
              
            ),
          );
        });
  }
}
