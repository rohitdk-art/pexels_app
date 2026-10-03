import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/pexels_repo.dart';
import '../data/pexels_image_model.dart';

class FeedState {
  final List<PexelsImageModel> photos;
  final bool isLoading;
  final bool isFetchingMore;
  final String? error;
  final int page;

  FeedState({
    this.photos = const [],
    this.isLoading = true,
    this.isFetchingMore = false,
    this.error,
    this.page = 1,
  });

  FeedState copyWith({
    List<PexelsImageModel>? photos,
    bool? isLoading,
    bool? isFetchingMore,
    String? error,
    int? page,
    bool clearError = false,
  }) {
    return FeedState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
      error: clearError ? null : (error ?? this.error),
      page: page ?? this.page,
    );
  }
}

final feedProvider = NotifierProvider<PexelsFeedNotifier, FeedState>(() {
  return PexelsFeedNotifier();
});

final pexelsFeedProvider = feedProvider;

class PexelsFeedNotifier extends Notifier<FeedState> {
  @override
  FeedState build() {
    Future.microtask(loadInitial);
    return FeedState();
  }

  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final startPage = Random().nextInt(10) + 1;
      final repo = ref.read(pexelsRepositoryProvider);
      final photos =
          await repo.fetchCuratedPhotos(page: startPage, perPage: 30);

      state = state.copyWith(
        photos: photos,
        isLoading: false,
        page: startPage,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadInitialPhotos() => loadInitial();

  Future<void> loadMore() async {
    if (state.isLoading || state.isFetchingMore) return;

    state = state.copyWith(isFetchingMore: true);
    try {
      final nextPage = state.page + 1;
      final repo = ref.read(pexelsRepositoryProvider);
      final morePhotos =
          await repo.fetchCuratedPhotos(page: nextPage, perPage: 30);

      state = state.copyWith(
        photos: [...state.photos, ...morePhotos],
        page: nextPage,
        isFetchingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isFetchingMore: false);
    }
  }

  Future<void> loadMorePhotos() => loadMore();
}
