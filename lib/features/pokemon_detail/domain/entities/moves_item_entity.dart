import 'package:equatable/equatable.dart';

class MovesItemEntity extends Equatable {
  final int power;
  final int accuracy;
  final int pp;

  const MovesItemEntity({
    required this.power,
    required this.accuracy,
    required this.pp,
  });

  @override
  List<Object?> get props => [power, accuracy, pp];
}
