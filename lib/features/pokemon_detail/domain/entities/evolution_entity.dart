import 'package:equatable/equatable.dart';

class EvolutionEntity extends Equatable {
  final String name;
  final String imgUrl;

  const EvolutionEntity({required this.name, required this.imgUrl});

  @override
  List<Object?> get props => [name, imgUrl];
}
