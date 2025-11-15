import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../domain/entities/moves_entity.dart';

class MoveWidget extends StatefulWidget {
  const MoveWidget({super.key, required this.movesEntity, required this.color});

  final List<MovesEntity> movesEntity;
  final Color color;

  @override
  State<MoveWidget> createState() => _MoveWidgetState();
}

class _MoveWidgetState extends State<MoveWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: ListView(
        padding: EdgeInsets.only(bottom: 40),
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: widget.movesEntity.map((move) {
              final name = move.name.isNotEmpty
                  ? move.name[0].toUpperCase() + move.name.substring(1)
                  : '';

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: widget.color.withAlpha(48),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.color.withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Text(
                  Utils.capitalizeEachWord(name),
                  style: TextStyle(
                    color: widget.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
