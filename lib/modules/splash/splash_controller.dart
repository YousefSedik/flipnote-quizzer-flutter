import 'package:project/modules/splash/splash_services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  SplashServices services = Get.put(SplashServices());

  @override
  void onInit() async {
    bool s = await services.isUserLoggedIn();
    print(s);
    if (s == true) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
    super.onInit();
  }
}
