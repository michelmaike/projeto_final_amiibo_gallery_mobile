import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/models.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cards_controller.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AmiiboModelAdapter());
  Hive.registerAdapter(FavoriteModelAdapter());
  
  await Hive.openBox<UserModel>('users');
  await Hive.openBox<FavoriteModel>('favorites');
  await Hive.openBox('auth');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Amiibo Gallery',
      theme: ThemeData(
        primaryColor: const Color(0xFFE60012),
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE60012),
          elevation: 0,
        ),
      ),
      home: const InitialScreen(),
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/favorites', page: () => FavoritesScreen()),
      ],
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(AmiiboController());
    
    return Obx(() {
      final authController = Get.find<AuthController>();
      if (authController.isLoggedIn.value) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    });
  }
}
