import 'package:flutter/material.dart';

import 'special_offer_banner.dart';

class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return OfferBanner(
      sectionTitle: 'Special Offers',
      onSeeAll: () {
        // Navigate to offers page
      },
      offers: const [
        OfferBannerItem(
          offerText: '30%',
          offerTitle: "Today's Special!",
          description: 'Get a discount for every order today.',
          imagePath: 'assets/1.png',
        ),
        OfferBannerItem(
          offerText: '20%',
          offerTitle: 'Weekend Deal',
          description: 'Get a special discount this weekend.',
          imagePath: 'assets/2.png',
        ),
        OfferBannerItem(
          offerText: '50%',
          offerTitle: 'Mega Sale',
          description: 'Save up to 50% on selected products.',
          imagePath: 'assets/3.png',
        ),
      ],
    );
  }
}
