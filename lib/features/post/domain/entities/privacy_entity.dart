import 'package:tafaling/core/entities/entity.dart';

class PrivacyEntity extends Entity<int> {
  final String name;

  PrivacyEntity({super.id, required this.name});

  PrivacyEntity copyWith({int? id, String? name}) {
    return PrivacyEntity(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  List<Object?> get props => [id, name];
}
