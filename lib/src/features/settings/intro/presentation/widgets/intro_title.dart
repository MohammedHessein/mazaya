import 'package:flutter/material.dart';

class IntroTitle extends StatelessWidget {
  final int pageIndex;
  final String title;
  final TextStyle normalStyle;
  final TextStyle blueStyle;

  const IntroTitle({
    super.key,
    required this.pageIndex,
    required this.title,
    required this.normalStyle,
    required this.blueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final spans = highlightFromTitle(
      text: title,
      pageIndex: pageIndex,
      normalStyle: normalStyle,
      highlightedStyle: blueStyle,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }

  List<TextSpan> highlightFromTitle({
    required String text,
    required int pageIndex,
    required TextStyle normalStyle,
    required TextStyle highlightedStyle,
  }) {
    final tokens = text
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList(growable: false);

    if (tokens.isEmpty) return [TextSpan(text: text, style: normalStyle)];

    // Slide 0: highlight the 2nd token.
    // Slide 1: highlight the token that contains Latin characters.
    // Slide 2: highlight the 3rd token.
    final String highlightedToken = switch (pageIndex) {
      1 => tokens.firstWhere(
        (t) => RegExp(r'[A-Za-z]').hasMatch(t),
        orElse: () => tokens.length > 1 ? tokens[1] : tokens.first,
      ),
      2 =>
        tokens.length > 2
            ? tokens[2]
            : (tokens.length > 1 ? tokens[1] : tokens.first),
      _ => tokens.length > 1 ? tokens[1] : tokens.first,
    };

    final start = text.indexOf(highlightedToken);
    if (start < 0) return [TextSpan(text: text, style: normalStyle)];

    final end = start + highlightedToken.length;
    return [
      TextSpan(text: text.substring(0, start), style: normalStyle),
      TextSpan(text: text.substring(start, end), style: highlightedStyle),
      TextSpan(text: text.substring(end), style: normalStyle),
    ];
  }
}
