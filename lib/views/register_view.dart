import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_app/views/login.dart';
import 'package:to_do_app/widgets/top_left_photo.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<bool> signUp(String email, String password) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        log('User signed up successfully: ${response.user!.email}');
        return true;
      } else {
        log('Unexpected issue during sign-up.');
        return false;
      }
    } catch (e) {
      log('Sign up failed: $e');
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
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to Onboard! ",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(
                      "Let’s help to meet up your tasks.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    hintText: "Enter your name",
                    labelText: "Full Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
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
                    hintText: "Enter you email",
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
                    hintText: "Enter you pass",
                    labelText: "Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmPasswordController,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please confirm your password";
                  } else if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "Password does not match";
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
                    hintText: "Confirm your pass",
                    labelText: "Confirm Password"),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      if (await signUp(
                          emailController.text, passwordController.text)) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                TopLeftPhoto(child: Login())));
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Email already exists")));
                    }
                  },
                  child: const Text("Register"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account ? ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopLeftPhoto(child: Login()),
                          ));
                    },
                    child: const Text(
                      "Sign IN",
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
