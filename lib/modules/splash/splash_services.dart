import 'package:project/api/api.dart';
import 'package:get/get.dart' hide Response;

class SplashServices extends GetxService {
  final ApiClient apiClient = ApiClient();

  Future<bool> isUserLoggedIn() async {
    try {
      await apiClient.getProfile();
      return true;
    } catch (e) {
      return false;
    }
  }
}
