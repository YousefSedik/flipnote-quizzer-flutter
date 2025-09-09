import 'package:get/get.dart';
import 'package:project/modules/home/home_controller.dart';
import 'package:project/modules/home/home_service.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeService>(HomeService());
    Get.put<HomeController>((HomeController()));
  }
}
