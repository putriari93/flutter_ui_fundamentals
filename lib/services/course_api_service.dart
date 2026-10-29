import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CourseApiService {
  // 1. Konstanta apiUrl
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts_salah';

  // 2. Function asynchronous HTTP GET
  Future<List<dynamic>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      // 3. Tampilkan jumlah item pada debugPrint
      debugPrint('Berhasil memuat data. Jumlah item: ${data.length}');
      return data;
    } else {
      throw Exception('Gagal memuat data. HTTP Status: ${response.statusCode}');
    }
  }
}