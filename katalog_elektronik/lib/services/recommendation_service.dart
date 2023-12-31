// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:katalog_elektronik/models/open_ai_model.dart';


class RecommendationService {

  // Fungsi untuk mendapatkan rekomendasi dari API OpenAI
  static Future<GPTData> getRecommendation({
    required String electronic,
    required String budget,
    required String brand,
  }) async {
    try {

      // URL endpoint API OpenAI
      var url = Uri.parse("https://api.openai.com/v1/completions");

      // Header untuk permintaan HTTP, mencakup tipe konten dan otorisasi
      Map<String, String> headers = {
        "Content-Type": "application/json",
        // bagian ini saya langsung nembak api key nya pada bearer nya
        "Authorization": 'Bearer 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',
      };

      // pesan permintaan untuk model AI OpenAI
      String promptData =
      'Berikan beberapa rekomendasi barang elektronik beserta deskripsinya $electronic dengan brand $brand dan dengan harga $budget.';

      // data yang akan dikirim dalam permintaan HTTP
      final data = jsonEncode({
        "model": "text-davinci-003",
        "prompt": promptData,
        "max_tokens": 400,
        "temperature": 0.7,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
      });

      // mengirim permintaan HTTP POST ke API OpenAI
      var response = await http.post(
        url,
        headers: headers,
        body: data,
      );
      
      // Memeriksa status kode respon HTTP
      if (response.statusCode == 200) {

        // Jika berhasil, mengembalikan data rekomendasi dalam bentuk objek GPTData
        return gptDataFromJson(response.body);
      } else {
        print(response.statusCode);
        throw Exception('Failed to get recommendation');
      }
    } catch (e) {
      // Menangani pengecualian jika ada kesalahan dalam permintaan HTTP
      print(e);
      throw Exception('Failed to get recommendation');
    }
  }
}
