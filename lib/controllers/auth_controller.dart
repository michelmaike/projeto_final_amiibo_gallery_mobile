import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final RxString currentUser = ''.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    final box = Hive.box('auth');
    final username = box.get('currentUser');
    if (username != null) {
      currentUser.value = username;
      isLoggedIn.value = true;
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      final box = Hive.box<UserModel>('users');
      
      if (box.containsKey(username)) {
        Get.snackbar('erro', 'usuário já existe');
        return false;
      }

      final user = UserModel(username: username, password: password);
      await box.put(username, user);
      
      Get.snackbar('sucesso', 'usuário cadastrado com sucesso');
      return true;
    } catch (e) {
      Get.snackbar('erro', 'erro ao cadastrar usuário');
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try{
      final box = Hive.box<UserModel>('users');
      final user = box.get(username);

      if(user != null && user.password == password) {
        currentUser.value = username;
        isLoggedIn.value = true;
        
        final authBox = Hive.box('auth');
        await authBox.put('currentUser', username);
        
        Get.snackbar('sucesso', 'login realizado com sucesso');
        Get.offAllNamed('/home');
        return true;
      } else {
        Get.snackbar('erro', 'usuário ou senha incorretos');
        return false;
      }
    } catch (e) {
      Get.snackbar('erro', 'erro ao fazer login');
      return false;
    }
  }

  Future<void> logout() async {
    currentUser.value = '';
    isLoggedIn.value = false;
    
    final authBox = Hive.box('auth');
    await authBox.delete('currentUser');
    
    Get.offAllNamed('/login');
  }
}
