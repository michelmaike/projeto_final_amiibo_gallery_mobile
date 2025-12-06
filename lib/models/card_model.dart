import 'package:hive/hive.dart';

part 'card_model.g.dart';

@HiveType(typeId: 0)
class AmiiboModel {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String gameSeries;
  
  @HiveField(3)
  final String image;

  AmiiboModel({
    required this.id,
    required this.name,
    required this.gameSeries,
    required this.image,
  });

  factory AmiiboModel.fromJson(Map<String, dynamic> json) {
    String head = json['head'] ?? '';
    String tail = json['tail'] ?? '';
    String id = head + tail;
    
    return AmiiboModel(
      id: id,
      name: json['name'] ?? '',
      gameSeries: json['gameSeries'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
