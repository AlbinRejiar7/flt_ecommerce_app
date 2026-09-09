import 'package:flt_ecommerce_app/feature/cart/presentation/pages/cart_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_icons.dart';

import '../../../../core/widgets/app_icons.dart';
import '../../feature/products/presentation/pages/product_list_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    ProductListPage(),
    CartPage(),
    Center(child: Text('Orders')),
    Center(child: Text('Wallet')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: MyAppIcons(iconData: AppIcons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: MyAppIcons(iconData: AppIcons.cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: MyAppIcons(iconData: AppIcons.order),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: MyAppIcons(iconData: AppIcons.wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: MyAppIcons(iconData: AppIcons.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
