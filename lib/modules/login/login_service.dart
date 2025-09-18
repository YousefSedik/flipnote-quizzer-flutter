import 'package:project/api/api.dart';
import 'package:get/get.dart';

class LoginService extends GetxService {
  ApiClient apiClient = ApiClient();
  Future<bool> login(String email, String password) async {
    return await apiClient
        .login(email, password)
        .then((response) {
          if (response.statusCode == 200) {
            return true;
          }
          return false;
        })
        .catchError((error) {
          print("Error during login: $error");
          return false;
        });
  }
}
