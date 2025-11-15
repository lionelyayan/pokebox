import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';
import '../../domain/entities/pokemon_detail_entity.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key, required this.pokemonDetailEntity});

  final PokemonDetailEntity? pokemonDetailEntity;

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  String? _currentUrl;

  Future<void> _playCry(String url) async {
    try {
      if (_isPlaying && _currentUrl == url) {
        await _player.stop();
      }

      if (_isPlaying && _currentUrl != url) {
        await _player.stop();
      }

      await _player.play(UrlSource(url));

      _isPlaying = true;
      _currentUrl = url;
      setState(() {});

      _player.onPlayerComplete.listen((event) {
        _isPlaying = false;
        _currentUrl = null;
        setState(() {});
      });
    } catch (e) {
      debugPrint("Cry error: $e");
    }
  }

  void playLatest() {
    final url = widget.pokemonDetailEntity?.cries.latest;
    if (url != null) _playCry(url);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemonDetailEntity;

    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow(
            title: 'Height',
            value: Utils.convertPokemonHeight(pokemon?.height ?? 0),
          ),
          _infoRow(
            title: 'Weight',
            value: Utils.convertPokemonWeight(pokemon?.weight ?? 0),
          ),
          _infoRow(
            title: 'Abilities',
            value: Utils.listToString(pokemon?.abilities ?? []),
          ),
          _infoRow(
            title: 'Base Exp',
            value: '${pokemon?.baseExperience ?? 0} pts',
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: Text(
                  'Cry',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: InkWell(
                  onTap: playLatest,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Play',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _infoRow({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
