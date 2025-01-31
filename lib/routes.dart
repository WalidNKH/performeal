import 'package:get/get.dart';
import 'package:performeal/pages/mail_page.dart';
import 'package:performeal/pages/login_page.dart';
import 'package:performeal/pages/profil_page.dart';
import 'package:performeal/pages/register_page.dart';
import 'package:performeal/pages/start_page.dart';

String initialRoute = '/start';
String loginRoute = '/login';
String registerRoute = '/register';
String mailRoute = '/mail';
String profilRoute = '/profil';

final routes = [
  GetPage(name: profilRoute, page: () => const ProfilePage()),
  GetPage(name: loginRoute, page: () => LoginPage()),
  GetPage(name: mailRoute, page: () => const MailPage()),
  GetPage(name: registerRoute, page: () => const RegisterPage()),
  GetPage(name: initialRoute, page: () => const StartPage()),
];
