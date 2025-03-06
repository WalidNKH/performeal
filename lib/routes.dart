import 'package:get/get.dart';
import 'package:performeal/controllers/SecondOnboardingController.dart';
import 'package:performeal/pages/mail_page.dart';
import 'package:performeal/pages/login_page.dart';
import 'package:performeal/pages/onboarding_page.dart';
import 'package:performeal/pages/profil_page.dart';
import 'package:performeal/pages/register_page.dart';
import 'package:performeal/pages/second_onboarding_page.dart';
import 'package:performeal/pages/start_page.dart';

String initialRoute = '/start';
String loginRoute = '/login';
String registerRoute = '/register';
String mailRoute = '/mail';
String profilRoute = '/profil';
String onboardingRoute = '/onboarding';
String secondOnboardingRoute = '/secondonboarding';

final routes = [
  GetPage(name: profilRoute, page: () => const ProfilePage()),
  GetPage(name: loginRoute, page: () => const LoginPage()),
  GetPage(name: mailRoute, page: () => const MailPage()),
  GetPage(name: registerRoute, page: () => const RegisterPage()),
  GetPage(name: initialRoute, page: () => const StartPage()),
  GetPage(name: onboardingRoute, page: () => const OnboardingPage()),
  GetPage(
    name: secondOnboardingRoute, // doit correspondre exactement à la constante
    page: () => const SecondOnboardingPage(),
    transition:
        Transition.rightToLeft, // ajout d'une transition pour mieux voir
    binding: BindingsBuilder(() {
      Get.lazyPut(() => SecondOnboardingController());
    }),
  ),
];
