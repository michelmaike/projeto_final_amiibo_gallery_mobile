import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cards_controller.dart';
import '../widgets/favorite_card_widget.dart';
import '../widgets/app_drawer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final AmiiboController amiiboController = Get.find<AmiiboController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => amiiboController.loadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx(() => Text(
          'Minha Coleção (${amiiboController.favorites.length})',
          style: const TextStyle(color: Colors.white),
        )),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Obx(() {
        if (amiiboController.favorites.isEmpty) {
          return const Center(
            child: Text(
              'nenhum amiibo na coleção',
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: amiiboController.favorites.length,
          itemBuilder: (context, index) {
            final favorite = amiiboController.favorites[index];
            return Dismissible(
              key: Key(favorite.amiiboId),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                amiiboController.removeFavoriteFromList(favorite);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: FavoriteAmiiboWidget(favorite: favorite),
            );
          },
        );
      }),
    );
  }
}
