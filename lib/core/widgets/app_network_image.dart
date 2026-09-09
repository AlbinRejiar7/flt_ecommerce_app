import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_dimension.dart';
import '../constants/app_icons.dart';
import 'app_icons.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return _ImagePlaceholder(color: colors.onSurfaceVariant);
    }

    final image = CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: AppDimensions.loadingStrokeWidth,
          ),
        );
      },
      errorWidget: (_, _, _) {
        return _ImagePlaceholder(color: colors.onSurfaceVariant);
      },
    );

    if (borderRadius == null) {
      return image;
    }

    return ClipRRect(borderRadius: borderRadius!, child: image);
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final Color color;

  const _ImagePlaceholder({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyAppIcons(
        iconData: AppIcons.imageUnavailable,
        size: AppDimensions.imagePlaceholderIconSize,
        color: color,
      ),
    );
  }
}
