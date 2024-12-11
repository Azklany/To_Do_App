import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(255, 188, 134, 171),
                    offset: Offset(3, 5),
                    blurRadius: 30),
              ]),
              child: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 221, 203, 215),
                maxRadius: 100,
                child: Icon(
                  Icons.person,
                  size: 150,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 234, 208, 221),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    hintText: "Enter you name",
                    labelText: "Full Name"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 234, 208, 221),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "Enter you pass",
                    labelText: "Password"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 221, 203, 215)),
                onPressed: () {},
                child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
