import 'package:hive/hive.dart';

part 'favorite_model.g.dart';

@HiveType(typeId: 2)
class FavoriteModel {
  @HiveField(0)
  final String username;
  
  @HiveField(1)
  final String amiiboId;
  
  @HiveField(2)
  final String name;
  
  @HiveField(3)
  final String gameSeries;
  
  @HiveField(4)
  final String image;

  FavoriteModel({
    required this.username,
    required this.amiiboId,
    required this.name,
    required this.gameSeries,
    required this.image,
  });
}
