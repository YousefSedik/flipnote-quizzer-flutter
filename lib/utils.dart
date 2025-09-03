import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

Future<String> pickAndReadPdf(String result) async {
  File file = File(result);
  final PdfDocument document = PdfDocument(
    inputBytes: await file.readAsBytes(),
  );
  return PdfTextExtractor(document).extractText();
}

