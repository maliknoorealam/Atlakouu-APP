import 'package:atalakou/bottomnavigation/ib_main_navigation.dart';
import 'package:atalakou/bottomnavigation/lfj_main_navigation.dart';
import 'package:atalakou/bottomnavigation/lfs_main_navigation.dart';
import 'package:atalakou/models/category.dart';
import 'package:atalakou/models/expert.dart';
import 'package:atalakou/screens/lookingforservices/Sub_categories/Rate_service_page.dart';
import 'package:atalakou/screens/lookingforservices/Sub_categories/expert_details.dart';
import 'package:atalakou/screens/lookingforservices/Sub_categories/sub_cat_expert_results.dart';
import 'package:atalakou/screens/lookingforservices/Sub_categories/sub_categories_page.dart';
import 'package:flutter/material.dart';

import '../screens/common/choose_profile.dart';
import '../screens/common/splash_screen.dart';
import '../screens/lookingforservices/fav_service.dart';
import '../screens/lookingforservices/service_main.dart';
import '../screens/userauth/login.dart';
import '../screens/userauth/login_main_screen.dart';
import '../screens/userauth/signup.dart';

class AppRouter {
  static const String splashScreen = '/';
  static const String chooseProfileType = '/choose_profile_type';
  static const String chooseServer = '/choose_service';
  static const String favScreen = '/fav_experts';
  static const String signInOptions = '/sign_in_options';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forget_pass';
  static const String lfsMainScreen = '/service_navigation_screen';
  static const String lfjMainScreen = '/jobs_navigation_screen';
  static const String ibMainScreen = '/increase_business_navigation_screen';
  static const String subCategory = '/subcategory';
  static const String subCatExpertsResult = '/available_experts';
  static const String expertsDetail = '/expert_info';
  static const String rateServicePage = '/rate_service';


  //TODO for the screen with more than 1 argument implement using a different way as this one won't work
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: ((context) => const SplashScreen()),
          settings: const RouteSettings(name: splashScreen),
        ); // SplashScreen route
      case chooseServer:
        return MaterialPageRoute(
          builder: ((context) => const ServiceMain()),
          settings: const RouteSettings(name: chooseServer),
        );
      case favScreen:
        return MaterialPageRoute(
          builder: ((context) => const FavScreen()),
          settings: const RouteSettings(name: favScreen),
        );
      case signInOptions:
        return MaterialPageRoute(
          builder: ((context) => const SignInOptions()),
          settings: const RouteSettings(name: signInOptions),
        );
      case chooseProfileType:
        return MaterialPageRoute(
          builder: ((context) => const ChooseProfileType()),
          settings: const RouteSettings(name: chooseProfileType),
        );
      case login:
        return MaterialPageRoute(
          builder: ((context) => const LoginScreen()),
          settings: const RouteSettings(name: login),
        );
      case signup:
        return MaterialPageRoute(
          builder: ((context) => const SignUpScreen()),
          settings: const RouteSettings(name: signup),
        );
      case lfsMainScreen:
        return MaterialPageRoute(
          builder: ((context) => LFSMainScreen(startingIndex: args as int)),
          settings: const RouteSettings(name: lfsMainScreen),
        );
      case lfjMainScreen:
        return MaterialPageRoute(
          builder: ((context) => LFJMainScreen(startingIndex: args as int)),
          settings: const RouteSettings(name: lfjMainScreen),
        );
      case ibMainScreen:
        return MaterialPageRoute(
          builder: ((context) => IBMainScreen(startingIndex: args as int)),
          settings: const RouteSettings(name: ibMainScreen),
        );
      case subCategory:
        return MaterialPageRoute(
          builder: ((context) => SubCategory(category: args as Category)),
          settings: const RouteSettings(name: subCategory),
        );
      case subCatExpertsResult:
          return MaterialPageRoute(
            builder: ((context) => SubCatExpertsResult(
              categoryId: args as int,
              subCategoryId: args as int,
            )),
            settings: const RouteSettings(name: subCatExpertsResult),
          );
      case expertsDetail:
          return MaterialPageRoute(
            builder: ((context) => ResultDetails(
              expert: args as Expert,
              fromPage: args as int,
            )),
            settings: const RouteSettings(name: expertsDetail),
          );
      case rateServicePage:
        return MaterialPageRoute(
          builder: ((context) => RateServicePage(expert: args as Expert)),
          settings: const RouteSettings(name: rateServicePage),
        );
    }

    return null;
  }

}
