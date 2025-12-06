import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cards_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final amiiboController = Get.find<AmiiboController>();

    return Drawer(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: const RoundedRectangleBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFE60012),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amiibo Gallery',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 26,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Obx(() => Text(
                      authController.currentUser.value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFFE60012)),
            title: const Text('Início', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Get.back();
              Get.offNamed('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Color(0xFFE60012)),
            title: Obx(() => Text(
              'Minha Coleção (${amiiboController.favorites.length})',
              style: const TextStyle(color: Colors.black87),
            )),
            onTap: () {
              Get.back();
              Get.toNamed('/favorites');
            },
          ),
          const Divider(color: Colors.black12),
          ListTile(
            leading: const Icon(Icons.power_settings_new, color: Colors.red),
            title: const Text('sair', style: TextStyle(color: Colors.black87)),
            onTap: () {
              Get.back();
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
