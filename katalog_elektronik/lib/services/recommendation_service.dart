// recommendation_service.dart
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:katalog_elektronik/models/open_ai_model.dart';

class RecommendationService {
  static Future<GPTData> getRecommendation({
    required String electronic,
    required String budget,
    required String brand,
  }) async {
    try {
      var url = Uri.parse("https://api.openai.com/v1/completions");

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": 'Bearer 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',
      };

      String promptData =
      'Berikan beberapa rekomendasi barang elektronik beserta deskripsinya $electronic dengan brand $brand dan dengan harga $budget.';

      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "max_tokens": 400,
        "temperature": 0.7,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      });

      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );

      if (response.statusCode == 200) {
        return gptDataFromJson(response.body);
      } else {
        print(response.statusCode);
        throw Exception('Failed to get recommendation');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to get recommendation');
    }
  }
}
