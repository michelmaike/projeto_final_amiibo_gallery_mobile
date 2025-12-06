import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cards_controller.dart';
import '../widgets/card_widget.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amiiboController = Get.find<AmiiboController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Amiibo Gallery', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                hintText: 'buscar por nome ou série...',
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.search, color: Color(0xFFE60012)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
              ),
              onChanged: (value) => amiiboController.searchAmiibos(value),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (amiiboController.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE60012)),
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
                itemCount: amiiboController.filteredAmiibos.length,
                itemBuilder: (context, index) {
                  final amiibo = amiiboController.filteredAmiibos[index];
                  return Obx(() {
                    final isFav = amiiboController.isFavorite(amiibo.id);
                    return Stack(
                      children: [
                        AmiiboWidget(amiibo: amiibo),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: SizedBox(
                            width: 32,
                            height: 32,
                            child: FloatingActionButton(
                              mini: true,
                              backgroundColor: isFav ? const Color(0xFFE60012) : Colors.white,
                              onPressed: () => amiiboController.toggleFavorite(amiibo),
                              child: Icon(
                                isFav ? Icons.remove : Icons.add,
                                color: isFav ? Colors.white : const Color(0xFFE60012),
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
