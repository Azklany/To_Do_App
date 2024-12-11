import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/views/login.dart';
import 'package:to_do_app/widgets/top_left_photo.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF0F4F3)),
      home: const TopLeftPhoto(child: Login())
    );
  }
}
