import 'package:get/get.dart';
import '../models/card_model.dart';
import '../models/favorite_model.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';
import 'auth_controller.dart';

class AmiiboController extends GetxController {
  final RxList<AmiiboModel> amiibos = <AmiiboModel>[].obs;
  final RxList<AmiiboModel> filteredAmiibos = <AmiiboModel>[].obs;
  final RxList<FavoriteModel> favorites = <FavoriteModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxInt favoriteCount = 0.obs;
  final RxSet<String> favoriteIds = <String>{}.obs;

  late FavoriteService _favoriteService;
  late AuthController _authController;

  @override
  void onInit() {
    super.onInit();
    _favoriteService = FavoriteService();
    _authController = Get.find<AuthController>();
    loadAmiibos();
    loadFavorites();
  }

  Future<void> loadAmiibos() async {
    try{
      isLoading.value = true;
      final amiibosList = await ApiService.getAmiibos();
      amiibos.value = amiibosList;
      filteredAmiibos.value = amiibosList;
    }catch (e) {
      Get.snackbar('erro', 'erro ao carregar amiibos: $e');
    }finally{
      isLoading.value = false;
    }
  }

  void searchAmiibos(String query) {
    searchQuery.value = query;
    if(query.isEmpty) {
      filteredAmiibos.value = amiibos;
    }else{
      filteredAmiibos.value = amiibos.where((amiibo) => 
              amiibo.name.toLowerCase().contains(query.toLowerCase()) ||
              amiibo.gameSeries.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  void loadFavorites() {
    if(_authController.isLoggedIn.value) {
      final userFavorites = _favoriteService.getFavoritesByUser(_authController.currentUser.value);
      favorites.assignAll(userFavorites);
      favoriteCount.value = userFavorites.length;
      favoriteIds.value = userFavorites.map((f) => f.amiiboId).toSet();
    }
  }

  bool isFavorite(String amiiboId) {
    return favoriteIds.contains(amiiboId);
  }

  Future<void> toggleFavorite(AmiiboModel amiibo) async {
    if(!_authController.isLoggedIn.value) {
      Get.snackbar('erro', 'faça login para favoritar amiibos');
      return;
    }

    if(isFavorite(amiibo.id)) {
      await _favoriteService.removeFavorite(_authController.currentUser.value, amiibo.id);
      favorites.removeWhere((fav) => fav.amiiboId == amiibo.id);
      favoriteIds.remove(amiibo.id);
      favoriteCount.value--;
      Get.snackbar('removido', '${amiibo.name} removido da coleção');
    } else {
      final favorite = FavoriteModel(
        username: _authController.currentUser.value,
        amiiboId: amiibo.id,
        name: amiibo.name,
        gameSeries: amiibo.gameSeries,
        image: amiibo.image,
      );
      await _favoriteService.addFavorite(favorite);
      favorites.add(favorite);
      favoriteIds.add(amiibo.id);
      favoriteCount.value++;
      Get.snackbar('adicionado', '${amiibo.name} adicionado a coleção');
    }
  }

  Future<void> removeFavoriteFromList(FavoriteModel favorite) async {
    await _favoriteService.removeFavorite(favorite.username, favorite.amiiboId);
    favorites.removeWhere((fav) => fav.amiiboId == favorite.amiiboId);
    favoriteIds.remove(favorite.amiiboId);
    favoriteCount.value--;
    Get.snackbar('removido', '${favorite.name} removido da coleção');
  }
}
