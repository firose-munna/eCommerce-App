import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/category_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../../state_holders/new_product_controller.dart';
import '../../state_holders/popular_product_controller.dart';
import '../../state_holders/product_slider_controller.dart';
import '../../state_holders/special_product_controller.dart';
import './category_list_screen.dart';
import './home_screen.dart';
import './wish_list_screen.dart';
import './cart_screen.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final List<Widget> _screens = const[
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<ProductSliderController>().getHomeSlider();
      Get.find<CategoryController>().getCategory();
      Get.find<PopularProductController>().getPopularProduct();
      Get.find<SpecialProductController>().getSpecialProduct();
      Get.find<NewProductController>().getNewProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GetBuilder<MainBottomNavController>(
      builder: (mainBottomNavController) {
        return Scaffold(
          body: _screens[mainBottomNavController.currentSelectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: theme.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: mainBottomNavController.currentSelectedIndex,
            onTap: (value) {
              mainBottomNavController.changeScreen(value);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'Home',
                tooltip: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Categories',
                tooltip: 'Categories',
                icon: Icon(Icons.category_outlined),
                activeIcon: Icon(
                  Icons.category,
                  color: Colors.green,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                tooltip: 'Cart',
                icon: Icon(Icons.shopping_cart),
              ),
              BottomNavigationBarItem(
                label: 'Wish',
                tooltip: 'Wish',
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
                activeIcon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
