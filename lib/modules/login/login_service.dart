import 'package:get/get.dart';
import 'package:project/api/api.dart';

class LoginService extends GetxService {
  ApiClient apiClient = Get.put(ApiClient());
  void login(String email, String password) async {
    await 
    apiClient
        .login(email, password)
        .then((response) {
          if (response.statusCode == 200) {
            Get.offAllNamed('/home');
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text("Login failed. Please try again."),
            //     backgroundColor: Colors.black,
            //   ),
            // );
          }
        })
        .catchError((error) {
          print("Error during login: $error");
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text(
          //       "An error occurred. Please try again.",
          //     ),
          //     backgroundColor: Colors.black,
          //   ),
          // );
        });
  }
}
