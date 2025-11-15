import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static void setStatusBarLight() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF9F9F9),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFFF9F9F9),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static void setStatusBar(BuildContext context) {
    final theme = Theme.of(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: theme.colorScheme.primary,
        statusBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );
  }

  static void setTransparent({Brightness iconBrightness = Brightness.light}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: iconBrightness,
      ),
    );
  }

  static void resetToDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  static Color getColorFromName(String name) {
    final colors = [
      const Color(0xFF64B5F6),
      const Color(0xFF4DB6AC),
      const Color(0xFFBA68C8),
      const Color(0xFFFFB74D),
      const Color(0xFF81C784),
      const Color(0xFFFF8A65),
      const Color(0xFFA1887F),
      const Color(0xFF9575CD),
    ];

    int index = name.hashCode % colors.length;
    return colors[index];
  }

  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;

    return text
        .split(' ')
        .map(
          (word) =>
              word.isEmpty ? word : word[0].toUpperCase() + word.substring(1),
        )
        .join(' ');
  }

  static String convertPokemonHeight(int dm) {
    double meters = dm / 10.0;
    int cm = (meters * 100).round();

    double totalInches = meters * 39.3701;
    int feet = (totalInches ~/ 12);
    double inches = totalInches % 12;

    return "$feet'${inches.toStringAsFixed(1)}\" (${meters.toStringAsFixed(2)} m / $cm cm)";
  }

  static String convertPokemonWeight(int hg) {
    double kg = hg / 10.0;
    double lbs = kg * 2.20462;

    return "${lbs.toStringAsFixed(1)} lbs (${kg.toStringAsFixed(1)} kg)";
  }

  static String listToString(List<String> str) {
    return str.map((a) => a[0].toUpperCase() + a.substring(1)).join(', ');
  }

  static Color statColor(int value) {
    if (value > 0 && value <= 60) {
      return Colors.red;
    } else if (value > 60 && value <= 120) {
      return Colors.yellow[700]!;
    } else {
      return Colors.green;
    }
  }

  static String getLastNumber(String url) {
    final regex = RegExp(r'(\d+)/?$');
    final match = regex.firstMatch(url);
    return match?.group(1) ?? '';
  }

  static int getTotalPage(int count, int limit) {
    return (count / limit).ceil();
  }

  static int getCurrentPage(int offset, int limit) {
    return (offset / limit).floor() + 1;
  }

  static int getLastPage(int count, int limit) {
    return getTotalPage(count, limit);
  }
}
