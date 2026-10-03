import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../feed/data/pexels_image_model.dart';
import '../../saved/providers/saved_provider.dart';

class PhotoDetailScreen extends ConsumerWidget {
  final PexelsImageModel photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedPhotos = ref.watch(savedProvider);
    final isSaved = savedPhotos.any((p) => p.id == photo.id);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(
                    text:
                        'Check out this amazing photo by ${photo.photographer} on Pexels: ${photo.largeUrl}'),
              );
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          InteractiveViewer(
            child: Image.network(
              photo.largeUrl,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Photographer',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          photo.photographer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      ref.read(savedProvider.notifier).toggleSave(photo);
                    },
                    backgroundColor: isSaved ? Colors.white : Colors.white24,
                    child: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      color: isSaved ? Colors.black : Colors.white,
                    ).animate(key: ValueKey(isSaved)).scale(
                          duration: 300.ms,
                          curve: Curves.easeOutBack,
                          begin: const Offset(0.5, 0.5),
                          end: const Offset(1.0, 1.0),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
