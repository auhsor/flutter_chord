import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Can parse single line chord', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, _) {
          String text = '[C]This is t[D]he lyrics[E]';
          final textStyle = TextStyle(fontSize: 18, color: Colors.green);

          final processor = ChordProcessor(context);
          final chordDocument = processor.processText(
            text: text,
            lyricsStyle: textStyle,
            chordStyle: textStyle,
          );

          expect(
            chordDocument.chordLyricsLines.length,
            1,
          );
          expect(
            chordDocument.chordLyricsLines.first.chords.length,
            3,
          );
          expect(
            chordDocument.chordLyricsLines.first.chords.first.chordText,
            'C',
          );
          expect(
            chordDocument.chordLyricsLines.first.chords.first.leadingSpace,
            0.0,
          );

          expect(
            chordDocument.chordLyricsLines.first.chords[1].chordText,
            'D',
          );

          final textWidth = processor.textWidth('This is t', textStyle);
          final chordWidth = processor.textWidth('C', textStyle);
          expect(
            chordDocument.chordLyricsLines.first.chords[1].leadingSpace,
            textWidth - chordWidth,
          );

          // The builder function must return a widget.
          return Container();
        },
      ),
    );
  });
}
