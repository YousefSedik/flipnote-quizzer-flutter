import 'package:project/modules/profile/profile_controller.dart';
import 'package:project/widgets/app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    print("Building Profile Screen");
    return Scaffold(
      appBar: getAppBar(title: controller.user?.username),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            spacing: 10,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                // backgroundImage: AssetImage('assets/profile_placeholder.png'),
              ),
              Text(
                "@${controller.user?.username.toLowerCase()}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  if (controller.hasListeners) followButton(),
                  shareProfileButton(),
                ],
              ),

              Container(
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    // FollowersCounter(controller: controller),
                    // FollowingCount(controller: controller),
                    // QuizCount(controller: controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget followButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () {
        controller.follow();
      },
      child: Text('Follow', style: TextStyle(color: Colors.white)),
    );
  }

  Widget unfollowButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
      onPressed: () {
        controller.unFollow();
      },
      child: Text('Follow', style: TextStyle(color: Colors.white)),
    );
  }

  Widget shareProfileButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]),
      onPressed: () {
        SharePlus.instance.share(
          ShareParams(text: 'check out my profile at flipnote quizzer'),
        );
      },
      child: Icon(Icons.share, color: Colors.black),
    );
  }
}

class QuizCount extends StatelessWidget {
  const QuizCount({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${controller.user?.quizzesCount}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Quizzes'),
        ],
      ),
    );
  }
}

class FollowingCount extends StatelessWidget {
  const FollowingCount({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${controller.user?.followersCount}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Following'),
        ],
      ),
    );
  }
}

class FollowersCounter extends StatelessWidget {
  const FollowersCounter({super.key, required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${controller.user?.followersCount}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Followers'),
        ],
      ),
    );
  }
}

// admin should approve teacher account creation
// teacher can create class room 
// can add students to class room
