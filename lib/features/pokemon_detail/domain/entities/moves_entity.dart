import 'package:equatable/equatable.dart';

class MovesEntity extends Equatable {
  final String name;
  final String url;

  const MovesEntity({required this.name, required this.url});

  @override
  List<Object?> get props => [name, url];
}
