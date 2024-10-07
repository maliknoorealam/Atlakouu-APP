import 'package:atalakou/databases/category_service.dart';
import 'package:atalakou/databases/contact_service.dart';
import 'package:atalakou/databases/experts_service.dart';
import 'package:atalakou/databases/jobs_service.dart';
import 'package:atalakou/routes/routes.dart';
import 'package:atalakou/screens/common/splash_screen.dart';
import 'package:atalakou/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'databases/ads_service.dart';
import 'databases/location_services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AdsService());
  Get.put(CategoryService());
  Get.put(ContactService());
  Get.put(ExpertsService());
  Get.put(JobService());
  Get.put(LocationServices());

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Atalakou',
        theme: MyTheme().myTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: '/',
        home: const SplashScreen());
  }
}
