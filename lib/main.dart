import 'package:flutter/material.dart';
import 'package:performeal/binding.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'routes.dart';

void main() async {
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1nZndyaWlzZGVkdHFybHlmcGJqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI1MzQ2NzcsImV4cCI6MjA0ODExMDY3N30.TBwY80yaLKXLUD-PunOfJ4UNm6BwLBzBJ_q7SiONCJI",
    url: "https://mgfwriisdedtqrlyfpbj.supabase.co",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue.shade800,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      initialRoute: initialRoute,
      getPages: routes,
      initialBinding: InitialScreenBindings(),
    );
  }
}
