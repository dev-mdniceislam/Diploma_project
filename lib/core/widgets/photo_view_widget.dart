import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CustomPhotoViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final bool isAsset;

  const CustomPhotoViewer({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.isAsset = false,
  });

  static void show(
    BuildContext context, {
    required List<String> imageUrls,
    int initialIndex = 0,
    bool isAsset = false,
  }) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: Colors.black,
      builder: (context) => Dialog.fullscreen(
        child: CustomPhotoViewer(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
          isAsset: isAsset,
        ),
      ),
    );
  }

  @override
  State<CustomPhotoViewer> createState() => _CustomPhotoViewerState();
}

class _CustomPhotoViewerState extends State<CustomPhotoViewer> {
  late int currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isMobile = mediaQuery.size.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              final imageProvider = widget.isAsset
                  ? AssetImage(widget.imageUrls[index]) as ImageProvider
                  : NetworkImage(widget.imageUrls[index]);

              return PhotoViewGalleryPageOptions(
                imageProvider: imageProvider,
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 2.5,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.imageUrls[index],
                ),
              );
            },
            itemCount: widget.imageUrls.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                          (event.expectedTotalBytes ?? 1),
                ),
              ),
            ),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          Positioned(
            top: mediaQuery.padding.top + 10,
            left: isMobile ? 16 : 30,
            right: isMobile ? 16 : 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close Button
                IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withAlpha(51),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),

                if (widget.imageUrls.length > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51), // ~20% Opacity
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentIndex + 1} / ${widget.imageUrls.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (!isMobile && widget.imageUrls.length > 1) ...[
            if (currentIndex > 0)
              Positioned(
                left: 20,
                child: IconButton.filledTonal(
                  iconSize: 28,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withAlpha(51), // ~20% Opacity
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            if (currentIndex < widget.imageUrls.length - 1)
              Positioned(
                right: 20,
                child: IconButton.filledTonal(
                  iconSize: 28,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withAlpha(51),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
          ],
        ],
      ),
    );
  }
}
