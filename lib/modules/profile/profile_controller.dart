import 'package:get/get.dart';
import 'package:project/models/user.dart';
import 'package:project/modules/profile/profile_service.dart';
import 'package:project/utils.dart';

class ProfileController extends GetxController {
  User? user;
  ProfileService profileService = Get.put<ProfileService>(ProfileService());
  int userId = Get.arguments['user_id'];

  Future<void> loadUser(int userId) async {
    // print("Loading user profile for userId: $userId, ${await isSameUser()}");
    if (await isSameUser()) {
      // print("Loading logged in user profile");
      user = await getCurrentUserModel();
      print("if Loaded user: ${user!.username}");
    } else {
      user = await profileService.getUser(userId);
      print("else Loaded user: ${user!.username}");

    }
    if (user == null) {
      print("User not found");
      Get.snackbar("Error", "User not found");
      Get.back();
      return;
    } else {
      print("Loaded user: ${user!.username}");
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    print("user_id ${Get.arguments['user_id']}");
    await loadUser(Get.arguments['user_id']);
  }

  Future<bool> isSameUser() async {
    User? currentUser = await getCurrentUserModel();
    print(currentUser == null);
    if (currentUser == null) {
      return false;
    }

    print(userId == currentUser.id);
    return userId == currentUser.id;
  }

  void follow() {
    // profileService.follow(user.id);
  }

  void unFollow() {}
}
