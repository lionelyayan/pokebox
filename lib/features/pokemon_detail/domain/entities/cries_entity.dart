import 'package:equatable/equatable.dart';

class CriesEntity extends Equatable {
  final String latest;
  final String legacy;

  const CriesEntity({required this.latest, required this.legacy});

  @override
  List<Object?> get props => [latest, legacy];
}
