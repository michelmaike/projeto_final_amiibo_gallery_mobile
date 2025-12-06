import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFE60012),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cadastro',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE60012),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: usernameController,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                labelText: 'Usuário',
                labelStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.person, color: Color(0xFFE60012)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.key, color: Color(0xFFE60012)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                labelText: 'Confirmar Senha',
                labelStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.key, color: Color(0xFFE60012)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE60012)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if(passwordController.text != confirmPasswordController.text) {
                    Get.snackbar('erro', 'senhas não coincidem');
                    return;
                  }
                  
                  final success = await authController.register(
                    usernameController.text,
                    passwordController.text,
                  );
                  if(success) {
                    Get.snackbar('Sucesso', 'Registrado com sucesso!');
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      Get.back();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE60012),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'cadastrar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
