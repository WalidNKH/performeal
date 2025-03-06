import 'package:get/get.dart';
import 'package:performeal/controllers/AuthController.dart';
import 'package:performeal/controllers/OnboardingController.dart';

class InitialScreenBindings implements Bindings {
  InitialScreenBindings();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
  }
}
