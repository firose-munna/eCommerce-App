import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../presentation/ui/screens/splash_screen.dart';
import '../presentation/ui/utility/app_colors.dart';
import './state_holder_binder.dart';

class CraftyBay extends StatefulWidget {
  static final GlobalKey<NavigatorState> globalKey =
      GlobalKey<NavigatorState>();
  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  late final StreamSubscription<ConnectivityResult> _connectivityResultSubscription;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
    checkInternetConnectivityStatus();
  }

  @override
  void dispose() {
    _connectivityResultSubscription.cancel();
    super.dispose();
  }

  Future<void> checkInternetConnectivity() async {
    final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
    handleConnectivityStates(connectivityResult);
  }

  void checkInternetConnectivityStatus() {
    _connectivityResultSubscription = Connectivity().onConnectivityChanged.listen((connectionResult) {
      handleConnectivityStates(connectionResult);
    });
  }

  void handleConnectivityStates(ConnectivityResult connectionResult) {
    if (connectionResult != ConnectivityResult.mobile &&
        connectionResult != ConnectivityResult.wifi) {
      Get.showSnackbar(const GetSnackBar(
        title: 'No internet!',
        message: 'Check your internet connectivity.',
        isDismissible: false,
      ));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      Get.snackbar(
        'Connected to internet!',
        'You are online.',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: CraftyBay.globalKey,
      initialBinding: StateHolderBinder(),
      title: 'CraftyBay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(
          AppColor.primaryColor.value,
          AppColor().color,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(
          AppColor.primaryColor.value,
          AppColor().color,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
