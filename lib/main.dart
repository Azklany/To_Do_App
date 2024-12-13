import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_app/views/splash_screen.dart';
import 'package:to_do_app/widgets/top_left_photo.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://atoisswnrzeddgmacvuy.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF0b2lzc3ducnplZGRnbWFjdnV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5NzcxMjIsImV4cCI6MjA0OTU1MzEyMn0.YreFv0-70Jckj-QcB0jDTc8QUzxGXwG97HkeaH5eI4s",
  );
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
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xFF50C2C9)),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                )),
          ),
          scaffoldBackgroundColor: const Color(0xFFF0F4F3)),
      home: const TopLeftPhoto(child: SplashScreen()),
    );
  }
}
