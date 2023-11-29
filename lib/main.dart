import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Guess my number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool error = false;
  int randomValue = Random().nextInt(101);

  late int insertedValue;
  late String errorMessage;
  String messageValue = '';

  void displayMessage() {
    setState(() {
      if (randomValue == insertedValue) {
        messageValue = 'You tried $insertedValue. You guessed right';
        openDialog();
      } else if (insertedValue < randomValue) {
        messageValue = 'You tried $insertedValue. Try higher';
      } else if (insertedValue > randomValue) {
        messageValue = 'You tried $insertedValue. Try lower';
      }
    });
  }

  void close() {
    Navigator.of(context).pop();
  }

  Future<dynamic> openDialog() async => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: Text('You guessed right. Your value was:$insertedValue'),
          content: ElevatedButton(onPressed: close, child: const Text('Close'))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$randomValue', style: Theme.of(context).textTheme.headlineMedium),
            const Text(
              'I am thinking of a number between 1 and 100.',
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              'It is your turn to guess my number!',
            ),
            Text(messageValue, style: const TextStyle(fontSize: 20)),
            Card(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Try a number!',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    // decoration: InputDecoration(
                    //   errorText: errorMessage,
                    // ),
                    onChanged: (String value) {
                      setState(() {
                        insertedValue = int.parse(value);
                        if (insertedValue >= 101) {
                          errorMessage = 'Too big';
                        }
                      });
                    },
                  ),
                  ElevatedButton(onPressed: displayMessage, child: const Text('Guess'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
