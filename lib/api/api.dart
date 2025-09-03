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
          final accessToken = await storage.read(key: "access_token");
          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // try refresh
            final refreshToken = await storage.read(key: "refresh_token");
            if (refreshToken != null) {
              try {
                final response = await _dio.post(
                  "/auth/token/refresh/",
                  data: {"refresh": refreshToken},
                );
                final newAccess = response.data["access"];
                await storage.write(key: "access_token", value: newAccess);

                // retry original request with new token
                e.requestOptions.headers["Authorization"] = "Bearer $newAccess";
                final retryResponse = await _dio.fetch(e.requestOptions);
                return handler.resolve(retryResponse);
              } catch (refreshError) {
                // refresh failed → logout user
                await storage.deleteAll();
              }
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> getProfile() {
    return _dio
        .get("/auth/profile/")
        .then((response) {
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
      "/auth/login/",
      data: {"email": email, "password": password},
    );
    if (response.statusCode != 200) {
      return response;
    }
    print("Login successful, storing tokens.");
    await storage.write(key: "access_token", value: response.data["access"]);
    await storage.write(key: "refresh_token", value: response.data["refresh"]);
    return response;
  }

  Future<bool> isAuthenticated() async {
    final accessToken = await storage.read(key: "access_token");
    if (accessToken != null) {
      _dio
          .post("/auth/token/verify/", data: {"token": accessToken})
          .then((response) {
            if (response.statusCode == 200) {
              print("Token is valid.");
              return true;
            }
          })
          .catchError((error) {
            print("Token is invalid or expired: $error");
            return false;
          });
    }
    print("No access token found.");
    return false;
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

  Future<Response> getQuizzes() {
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

  Future<Response> deleteQuestion(int id, String type) {
    return _dio.delete("questions/$id/$type");
  }

  Future<Response> getQuestions(String id) {
    return _dio.get("questions/$id");
  }
}
