import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? '';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: baseUrl, validateStatus: (status) => true),
  );

  final storage = const FlutterSecureStorage();

  ApiClient() {

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: "token");
          print("Token: $token");
          if (token != null) {
            options.headers["Authorization"] = "Token $token";
          }
          return handler.next(options);
        },
      ),
    );
  }
  //
  Future<Response> getProfile() {
    return _dio
        .get("/auth/profile/")
        .then((response) {
          if (response.statusCode != 200) {
            throw Error();
          }
          print("Profile fetched successfully.");
          return response;
        })
        .catchError((error) {
          print("Failed to fetch profile: $error");
          throw error;
        });
  }

  Future<Response> login(String email, String password) async {
    Response response = await _dio.post(
      "auth/api-token-auth/",
      data: {"username": email, "password": password},
    );
    print("Login response: ${response.data}");
    print("Status code: ${response.statusCode}");
    if (response.statusCode != 200) {
      return response;
    }
    await storage.write(key: "token", value: response.data["token"]);
    return response;
  }

  Future<Response> signup(
    String username,
    String email,
    String password1,
    String password2,
  ) {
    return _dio.post(
      "/auth/register/",
      data: {
        "email": email,
        "password": password1,
        "password2": password2,
        "first_name": "first_name",
        "last_name": "last_name",
        "username": username,
      },
    );
  }

  Future<Response> logout() async {
    await storage.deleteAll();
    return _dio.post("/auth/logout/");
  }

  Future<Response> getHistory() {
    return _dio.get("quizzes/history");
  }

  Future<Response> getQuiz(String quizId) {
    return _dio.get("quizzes/$quizId");
  }

  Future<Response> getMyQuizzes() {
    return _dio.get("quizzes");
  }

  Future<Response> createQuiz(Map<String, dynamic> quizData) {
    return _dio.post("quizzes", data: quizData);
  }

  Future<Response> extractQuestions(String text) {
    return _dio.post("/extract-questions", data: {"content": text});
  }

  Future<Response> deleteQuiz(String id) {
    return _dio.delete("quizzes/$id");
  }

  Future<Response> deleteQuestion(String quizId, String id, String type) {
    return _dio.delete("quizzes/$quizId/questions/$id/$type");
  }

  Future<Response> getQuestions(String id) {
    return _dio.get("questions/$id");
  }

  Future<Response> createQuestion(Map<String, dynamic> map, String id) {
    return _dio.post("quizzes/$id/questions", data: map);
  }

  Future<Response> updateMCQQuestion(
    Map<String, dynamic> data,
    String Quizid,
    String questionId,
  ) {
    return _dio.put("quizzes/$Quizid/questions/$questionId/mcq", data: data);
  }

  Future<Response> updateWrittenQuestion(
    Map<String, dynamic> data,
    String Quizid,
    String questionId,
  ) {
    return _dio.put(
      "quizzes/$Quizid/questions/$questionId/written",
      data: data,
    );
  }

  Future<Response> updateQuiz(Map<String, dynamic> map) async {
    return _dio.put("quizzes/${map['id']}", data: map);
  }
}
