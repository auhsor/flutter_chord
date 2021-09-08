import 'dart:math';

import 'package:flutter/material.dart';
import 'model/chord_lyrics_document.dart';
import 'model/chord_lyrics_line.dart';

class ChordProcessor {
  final BuildContext context;
  ChordProcessor(this.context);

  /// Process the text to get the parsed ChordLyricsDocument
  ChordLyricsDocument processText({
    required String text,
    required TextStyle lyricsStyle,
    required chordStyle,
  }) {
    final lines = text.split('\n');
    List<ChordLyricsLine> _chordLyricsLines =
        lines.map<ChordLyricsLine>((line) {
      ChordLyricsLine _chordLyricsLine = ChordLyricsLine([], '');
      String _lyricsSoFar = '';
      String _chordsSoFar = '';
      bool _chordHasStarted = false;
      line.split('').forEach((character) {
        if (character == ']') {
          final sizeOfLeadingLyrics = textWidth(_lyricsSoFar, lyricsStyle);

          final lastChordText = _chordLyricsLine.chords.isNotEmpty
              ? _chordLyricsLine.chords.last.chordText
              : '';

          final lastChordWidth = textWidth(lastChordText, chordStyle);
          // final sizeOfThisChord = textWidth(_chordsSoFar, chordStyle);

          double leadingSpace = 0;
          leadingSpace = (sizeOfLeadingLyrics - lastChordWidth);

          leadingSpace = max(0, leadingSpace);

          _chordLyricsLine.chords.add(Chord(leadingSpace, _chordsSoFar));
          _chordLyricsLine.lyrics += _lyricsSoFar;
          _lyricsSoFar = '';
          _chordsSoFar = '';
          _chordHasStarted = false;
        } else if (character == '[') {
          _chordHasStarted = true;
        } else {
          if (_chordHasStarted) {
            _chordsSoFar += character;
          } else {
            _lyricsSoFar += character;
          }
        }
      });

      _chordLyricsLine.lyrics += _lyricsSoFar;

      return _chordLyricsLine;
    }).toList();

    return ChordLyricsDocument(_chordLyricsLines);
  }

  double textWidth(String text, TextStyle textStyle) {
    return (TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
    )..layout())
        .size
        .width;
  }
}