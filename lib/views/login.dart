import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_app/cubits/new_task_cubit.dart';
import 'package:to_do_app/views/dash_board_screen.dart';
import 'package:to_do_app/views/register_view.dart';
import 'package:to_do_app/widgets/top_left_photo.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        log('User signed in successfully: ${response.session!.user.email}');
        return true;
      } else {
        log('Unexpected issue during sign-in.');
        return false;
      }
    } catch (e) {
      log('Sign in failed: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> globalKey = GlobalKey();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: globalKey,
          child: ListView(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/draw_back.png",
                height: 138,
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: "Enter your email",
                    labelText: "Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "Enter you password",
                    labelText: "Password"),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Forget password ?",
                        style: TextStyle(color: Color(0xff50C2C9)),
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (await signIn(
                        emailController.text, passwordController.text)) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TopLeftPhoto(
                                  child: BlocProvider(
                                create: (context) => NewTaskCubit(),
                                child: DashBoardScreen(),
                              ))));
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid email or password")));
                  },
                  child: const Text("Login"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don`t have an account ? ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TopLeftPhoto(child: RegisterView()),
                          ));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Color(0xff50C2C9)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
