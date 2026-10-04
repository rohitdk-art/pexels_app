import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pexels_image_model.dart';
import 'package:flutter/foundation.dart';
import '../../../api_key.dart';

final pexelsRepositoryProvider = Provider<PexelsRepo>((ref) => PexelsRepo());

class PexelsRepo {
  static const String _apiKey = pexelsApiKey; // Replace with your actual Pexels API key
  static const String _baseUrl = 'https://api.pexels.com/v1';

  Future<List<PexelsImageModel>> fetchCuratedPhotos(
      {int page = 1, int perPage = 20}) async {
    try {
      final uri = Uri.parse('$_baseUrl/curated?page=$page&per_page=$perPage');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List dynamicPhotos = data['photos'];

        return dynamicPhotos
            .map((json) => PexelsImageModel.fromJson(json))
            .toList();
      } else {
        debugPrint(
            'PEXELS REJECTED: Code ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<PexelsImageModel>> searchPhotos(
    String query, {
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl/search?query=${Uri.encodeComponent(query)}&page=$page&per_page=$perPage',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List dynamicPhotos = data['photos'];

        return dynamicPhotos
            .map((json) => PexelsImageModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to search photos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error during search: $e');
    }
  }
}
