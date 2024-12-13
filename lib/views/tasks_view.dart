import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TasksView extends StatelessWidget {
  TasksView({super.key});
  Future<void> signOut() async {
  try {
    await Supabase.instance.client.auth.signOut();
    log('User signed out successfully!');
  } catch (e) {
    log('Sign out failed: $e');
  }
}

  final _future = Supabase.instance.client.from('countries').select();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: (){
            signOut();
          }, child: const Text("Sign Out")),
        ));
  }
}
