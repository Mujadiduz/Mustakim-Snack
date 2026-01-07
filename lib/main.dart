import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mustakim_snack/auth_controller.dart';
import 'package:mustakim_snack/introduce_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://yhopbuwxpwizoxklqfui.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlob3BidXd4cHdpem94a2xxZnVpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc3OTYyNDMsImV4cCI6MjA4MzM3MjI0M30.C5wWwsRnglsoQWyj3_T1EUDM14qdR90-VCohIWTYEPU',
  );
  Get.put(AuthController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroduceScreen(),
    );
  }
}
