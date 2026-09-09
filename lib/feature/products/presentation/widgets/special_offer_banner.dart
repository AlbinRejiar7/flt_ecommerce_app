import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/app_spacing.dart';

class OfferBannerItem {
  final String offerText;
  final String offerTitle;
  final String description;
  final String imagePath;

  const OfferBannerItem({
    required this.offerText,
    required this.offerTitle,
    required this.description,
    required this.imagePath,
  });
}

class OfferBanner extends StatefulWidget {
  final String sectionTitle;
  final List<OfferBannerItem> offers;
  final VoidCallback? onSeeAll;

  const OfferBanner({
    super.key,
    required this.sectionTitle,
    required this.offers,
    this.onSeeAll,
  });

  @override
  State<OfferBanner> createState() => _OfferBannerState();
}

class _OfferBannerState extends State<OfferBanner> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (widget.offers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.xl,
        AppSpacing.md,
      ),
      child: Column(
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.sectionTitle, style: theme.textTheme.titleLarge),
              TextButton(
                onPressed: widget.onSeeAll,
                child: const Text('See All'),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          /// Carousel + Indicator
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                itemCount: widget.offers.length,
                itemBuilder: (context, index, realIndex) {
                  return _OfferCard(offer: widget.offers[index]);
                },
                options: CarouselOptions(
                  height: 170,
                  viewportFraction: 1,
                  enableInfiniteScroll: widget.offers.length > 1,
                  pageSnapping: true,
                  initialPage: 0,
                  enlargeCenterPage: false,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),

              /// Indicator inside the banner
              Positioned(
                bottom: AppSpacing.sm,
                child: AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: widget.offers.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 7,
                    spacing: 6,
                    expansionFactor: 3,
                    activeDotColor: colors.primary,
                    dotColor: colors.outlineVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final OfferBannerItem offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.extraLarge),
      ),
      child: Stack(
        children: [
          /// Text Content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: AppDimensions.offerVisualSize,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.offerText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headlineLarge,
                          ),

                          const SizedBox(height: AppSpacing.xs),

                          Text(
                            offer.offerTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium,
                          ),

                          const SizedBox(height: AppSpacing.sm),

                          Text(
                            offer.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Image
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset(
              offer.imagePath,
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
