import 'package:flutter/material.dart';

class TestPage3 extends StatelessWidget {
  const TestPage3({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.science),
            Text("test3"),
          ],
        ),
      ),
      body: const Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Text('hello, Test3.')),
    );
  }
}
