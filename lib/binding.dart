import 'package:get/get.dart';
import 'package:performeal/controllers/AuthController.dart';

class InitialScreenBindings implements Bindings {
  InitialScreenBindings();

  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
