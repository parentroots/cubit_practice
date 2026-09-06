import 'package:cubit_practice/features/gallery/presentation/screen/gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GalleryScreen(),
      ),
    );
  }
}
