import 'package:flutter/material.dart';
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          const TopLeftPhoto(child: Login())));
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
