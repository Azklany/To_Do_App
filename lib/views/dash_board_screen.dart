import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_app/cubits/new_task_cubit.dart';
import 'package:to_do_app/views/login.dart';
import 'package:to_do_app/widgets/top_left_photo.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  Future<bool> signOut() async {
    try {
      await Supabase.instance.client.auth.signOut();
      log('User signed out successfully!');
      return true;
    } catch (e) {
      log('Sign out failed: $e');
      return false;
    }
  }

  final TextEditingController taskController = TextEditingController();
  final TextEditingController editController = TextEditingController();
  String returnName() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user!.userMetadata!['name'] != null) {
      String? name = user.userMetadata?['name']; // Access the stored name
      log('User name: $name');
      return name!;
    } else {
      String name = "skyLine";
      return name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final newTaskCubit = context.read<NewTaskCubit>();
    newTaskCubit.fetch();
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
                          onPressed: () async {
                            if (await signOut()) {
                              await Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => TopLeftPhoto(
                                    child: Login(),
                                  ),
                                ),
                              );
                            }
                          },
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
                Text(
                  "Welcome ${returnName()}",
                  style: const TextStyle(
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
                  "Welcome",
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
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
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style:
                                            TextStyle(color: Color(0xFF50C2C9)),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (taskController.text.isNotEmpty) {
                                          newTaskCubit.addNewTask(
                                              taskController.text, false);
                                        }
                                        taskController.clear();
                                        Navigator.of(ctx).pop();
                                      },
                                      child: const Text('Add',
                                          style: TextStyle(
                                              color: Color(0xFF50C2C9))),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: Color(0xFF50C2C9),
                          )),
                    ],
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<NewTaskCubit, List<Map<String, dynamic>>>(
                    builder: (context, state) {
                      return state.isEmpty
                          ? const SingleChildScrollView(
                              child: Text(
                                'No Task',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: state.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: state[index]['isCompleted'],
                                            onChanged: (value) {
                                              newTaskCubit.toggleState(index);
                                            },
                                            activeColor:
                                                const Color(0xFF50C2C9),
                                          ),
                                          Text(
                                            state[index]['title'],
                                            style: TextStyle(
                                              decoration: state[index]
                                                      ['isCompleted']
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (ctx) {
                                                return AlertDialog(
                                                  title:
                                                      const Text('Edit Task'),
                                                  content: TextField(
                                                    controller: editController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Edit your task',
                                                            fillColor: Color(
                                                                0xFF50C2C9),
                                                            filled: true),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF50C2C9)),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        if (editController
                                                            .text.isNotEmpty) {
                                                          newTaskCubit
                                                              .updateTask(
                                                                  index,
                                                                  editController
                                                                      .text);
                                                        }
                                                        taskController.clear();
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: const Text('Add',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF50C2C9))),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Color(0xFF50C2C9),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                    },
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
