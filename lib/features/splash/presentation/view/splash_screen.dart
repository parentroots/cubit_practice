//this is comment==============================
//splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service/local_storage/local_storage_service.dart';
import '../../../home/presentation/view/home_screen.dart';
import '../../cubit/splash_cubit.dart';
import '../../cubit/splash_state.dart';
import '../../../auth/presentation/screen/login_scree.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //this is comment==============================
    //Rule: BlocProvider দিয়েই Cubit তৈরি হয় আর UI এর সাথে যুক্ত হয়
    //GetX এর Get.put(SplashController()) এর সমতুল্য এইটা
    return BlocProvider(
      create: (context) => SplashCubit(TokenStorageService())
        ..checkAuthStatus(), //Cubit তৈরি হওয়া মাত্রই checkAuthStatus() call হয়ে যাচ্ছে
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    //this is comment==============================
    //Rule: BlocListener = "side-effect" এর জন্য (navigation, snackbar, dialog)
    //এটা UI rebuild করে না, শুধু action নেয় যখন state বদলায়
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.authenticated) {
          //this is comment==============================
          //token পাওয়া গেছে → Home screen এ পাঠাও
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state.status == SplashStatus.unauthorized) {
          //this is comment==============================
          //token নেই → Login screen এ পাঠাও
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      },
      child: const Scaffold(
        body: Center(
          //this is comment==============================
          //আপাতত simple logo/loading, পরে চাইলে actual logo বসাবে
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 100),
              SizedBox(height: 24),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}