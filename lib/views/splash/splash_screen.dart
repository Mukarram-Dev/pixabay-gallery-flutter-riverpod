import 'package:pixabay_gallery/config/assets/image_assets.dart';
import 'package:pixabay_gallery/services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final splashService = SplashService();
    splashService.checkAndNavigate(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: Image.asset(
              ImageAssets.appLogo,
              height: size.height * 0.5,
              width: size.width * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
