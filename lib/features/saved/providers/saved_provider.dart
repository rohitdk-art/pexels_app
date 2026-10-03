import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../feed/data/pexels_image_model.dart';

final savedProvider =
    NotifierProvider<SavedNotifier, List<PexelsImageModel>>(() {
  return SavedNotifier();
});

class SavedNotifier extends Notifier<List<PexelsImageModel>> {
  @override
  List<PexelsImageModel> build() {
    Future.microtask(_loadSavedPhotos);
    return [];
  }

  Future<void> _loadSavedPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    final savedString = prefs.getString('saved_photos_data');

    if (savedString != null) {
      final List decoded = json.decode(savedString);
      state = decoded
          .map((item) =>
              PexelsImageModel.fromLocalJson(Map<String, dynamic>.from(item)))
          .toList();
    }
  }

  Future<void> toggleSave(PexelsImageModel photo) async {
    final isSaved = state.any((p) => p.id == photo.id);

    if (isSaved) {
      state = state.where((p) => p.id != photo.id).toList();
    } else {
      state = [...state, photo];
    }

    final prefs = await SharedPreferences.getInstance();
    final encodedList = json.encode(state.map((p) => p.toLocalJson()).toList());
    await prefs.setString('saved_photos_data', encodedList);
  }
}
