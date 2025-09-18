import 'package:get/get.dart';
import 'package:project/api/api.dart';
import 'package:project/models/user.dart';

class ProfileService extends GetxService {
  ApiClient apiClient = ApiClient();
  void follow(int id) {
    apiClient.follow(id);
  }

  Future<User?> getUser(int userId) async {
    apiClient.getUserInfo(userId).then((response) {
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      } else {
        return null;
      }
    }).catchError((error) {
      print("Error fetching user: $error");
      return null;
    });
  }
}
