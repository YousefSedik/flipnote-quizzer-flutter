import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/models/user.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

final storage = const FlutterSecureStorage();
Future<String> pickAndReadPdf(String result) async {
  File file = File(result);
  final PdfDocument document = PdfDocument(
    inputBytes: await file.readAsBytes(),
  );
  return PdfTextExtractor(document).extractText();
}

Future<User?> getCurrentUserModel() async {
  String? profileData;
  await storage.read(key: "profile").then((value) {
    profileData = value;
  });
  print(profileData == null);
  if (profileData != null) {
    return User.fromJson(jsonDecode(profileData!));
  } else {
    return null;
  }
}
