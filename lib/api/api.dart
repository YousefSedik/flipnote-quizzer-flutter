import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String baseUrl = "http://10.0.2.2:8000";

class ApiClient {
  final Dio _dio = Dio(BaseOptions(baseUrl: baseUrl));
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

  Future<Response> getProfile() => _dio.get("/auth/profile/");
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
    String firstName,
    String lastName,
    String username,
    String email,
    String password1,
    String password2,
  ) {
    return _dio.post(
      "/auth/register/",
      data: {
        "email": email,
        "password1": password1,
        "password2": password2,
        "first_name": firstName,
        "last_name": lastName,
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
}
