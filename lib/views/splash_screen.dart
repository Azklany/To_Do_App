import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_app/cubits/new_task_cubit.dart';
import 'package:to_do_app/views/dash_board_screen.dart';
import 'package:to_do_app/views/login.dart';
import 'package:to_do_app/widgets/top_left_photo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Image.asset("assets/splash.png"),
            const Column(
              children: [
                Text(
                  "Dream it. Plan it. Do it.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Every big achievement starts with a\n single step. Organize your day,\n conquer your goals.",
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  log(Supabase.instance.client.auth.currentSession.toString());
                  final session = Supabase.instance.client.auth.currentSession;
                  if (session != null) {
                    // User is logged in
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TopLeftPhoto(
                                child: BlocProvider(
                              create: (context) => NewTaskCubit(),
                              child: DashBoardScreen(),
                            ))));
                  } else {
                    // User is not logged in
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => TopLeftPhoto(child: Login())));
                  }
                },
                child: const Text("Get Started"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
