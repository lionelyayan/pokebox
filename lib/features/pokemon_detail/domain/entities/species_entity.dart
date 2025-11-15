import 'package:equatable/equatable.dart';

class SpeciesEntity extends Equatable {
  final String url;

  const SpeciesEntity({required this.url});

  @override
  List<Object?> get props => [url];
}
