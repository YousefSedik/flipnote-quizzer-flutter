class User {
  final int id;
  final String username;
  final int followingCount;
  final int followersCount;
  final String accountType;
  int quizzesCount; 
  User({
    required this.id,
    required this.username,
    required this.followingCount,
    required this.followersCount,
    required this.accountType,
    this.quizzesCount = 0,

  });

  static User fromJson(Map<String, dynamic> userInfo) {
    User user = User(
      id: userInfo['id'],
      username: userInfo['username'],
      followingCount: userInfo['following_count'],
      followersCount: userInfo['followers_count'],
      quizzesCount: userInfo['quizzes_count'] ?? 0,
      accountType: userInfo['account_type'],
    );
    return user;
  }
}
