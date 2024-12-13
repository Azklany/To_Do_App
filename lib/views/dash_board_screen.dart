import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final List<Map<String, dynamic>> tasks = [
    {'title': 'Learning Programming by 12PM', 'isCompleted': false},
    {'title': 'Learn how to cook by 1PM', 'isCompleted': false},
    {'title': 'Learn how to play at 2PM', 'isCompleted': false},
    {'title': 'Have lunch at 4PM', 'isCompleted': false},
    {'title': 'Going to travel 6PM', 'isCompleted': false},
  ];

  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
                hintText: 'Enter your task',
                fillColor: Color(0xFF50C2C9),
                filled: true),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF50C2C9)),
              ),
            ),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  setState(() {
                    tasks.add(
                        {'title': taskController.text, 'isCompleted': false});
                  });
                }
                taskController.clear();
                Navigator.of(context).pop();
              },
              child:
                  const Text('Add', style: TextStyle(color: Color(0xFF50C2C9))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: const Color(0xFF50C2C9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.logout_sharp,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/logo.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome Skyline",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Good Afternoon",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/clock.png"))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Task list",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Daily Task',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: _addNewTask,
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: Color(0xFF50C2C9),
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Checkbox(
                              value: tasks[index]['isCompleted'],
                              onChanged: (value) {
                                setState(() {
                                  tasks[index]['isCompleted'] = value!;
                                });
                              },
                              activeColor: Color(0xFF50C2C9),
                            ),
                            Text(
                              tasks[index]['title'],
                              style: TextStyle(
                                decoration: tasks[index]['isCompleted']
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
          )
        ],
      ),
    );
  }
}
