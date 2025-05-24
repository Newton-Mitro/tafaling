import 'package:tafaling/features/post/domain/entities/privacy_entity.dart';

class PrivacyModel extends PrivacyEntity {
  PrivacyModel({required int super.id, required super.name});

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
