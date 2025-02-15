import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/utils/helpers.dart';

class CachedImageWidget extends StatefulWidget {
  const CachedImageWidget(
      {super.key, required this.imageUrl, this.fit = BoxFit.cover});

  final String imageUrl;
  final BoxFit fit;

  @override
  State<CachedImageWidget> createState() => _CachedImageWidgetState();
}

class _CachedImageWidgetState extends State<CachedImageWidget> {
  File? _cachedImage;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    File? file = await cacheImage(widget.imageUrl);
    if (mounted) {
      setState(() {
        _cachedImage = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _cachedImage != null
        ? Image.file(_cachedImage!, fit: widget.fit)
        : Image.network(
            widget.imageUrl,
            loadingBuilder: (context, child, loadingProgress) {
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 50);
            },
            fit: widget.fit,
          );
  }
}
