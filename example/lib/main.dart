import 'package:flutter/material.dart';
import 'package:flutter_chord/flutter_chord.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chord',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final chordStyle = TextStyle(fontSize: 20, color: Colors.green);
  final textStyle = TextStyle(fontSize: 18, color: Colors.white);
  String _lyrics = '';
  int transposeIncrement = 0;
  int scrollSpeed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chord Example'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.teal,
              child: TextFormField(
                initialValue: _lyrics,
                style: textStyle,
                maxLines: 50,
                onChanged: (value) {
                  setState(() {
                    _lyrics = value;
                  });
                },
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            transposeIncrement--;
                          });
                        },
                        child: Text('-'),
                      ),
                      SizedBox(width: 5),
                      Text('$transposeIncrement'),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            transposeIncrement++;
                          });
                        },
                        child: Text('+'),
                      ),
                    ],
                  ),
                  Text('Transpose')
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: scrollSpeed <= 0
                            ? null
                            : () {
                                setState(() {
                                  scrollSpeed--;
                                });
                              },
                        child: Text('-'),
                      ),
                      SizedBox(width: 5),
                      Text('$scrollSpeed'),
                      SizedBox(width: 5),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            scrollSpeed++;
                          });
                        },
                        child: Text('+'),
                      ),
                    ],
                  ),
                  Text('Auto Scroll')
                ],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              color: Colors.black,
              child: LyricsRenderer(
                lyrics: _lyrics,
                textStyle: textStyle,
                chordStyle: chordStyle,
                onTapChord: (String chord) {
                  print('pressed chord: $chord');
                },
                transposeIncrement: transposeIncrement,
                scrollSpeed: scrollSpeed,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _lyrics = '''
[C]Give me Freedom, [F]Give me fire
[Am]Give me reason, [G]Take me higher
[C]See the champions [F], Take the field now
[Am]Unify us, [G]make us feel proud
 
[C]In the streets our, [F]hands are lifting
[Am]As we lose our, [G]inhibition
[C]Celebration, [F]its around us
[Am]Every nation, [G]all around us
''';
  }
}
