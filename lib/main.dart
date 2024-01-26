import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/page2.dart';
import 'package:url_launcher/url_launcher.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // String _type = "偶数";
  bool _myfeeling = false;

  double _progressValue = 0;
  void _getProgress() {
    _progressValue = ((_counter % 100) / 100);
  }

  // ドラムローラーのための日付の変数を追加
  DateTime targetDay = DateTime.now();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      // (_counter % 2 == 0) ? _type = "偶数" : _type = "奇数";
    });
  }

  void _changeMyFeeling() {
    setState(() {
      _myfeeling = !_myfeeling;
    });
  }

  final Uri _url = Uri.parse("https://www.apple.com");

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw "Could not launch ${_url.toString()}";
  }

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
            Icon(Icons.home),
            Text("ホームです"),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            (_counter % 2 == 1)
                ? const Text('奇数',
                    style: TextStyle(fontSize: 20, color: Colors.red))
                : const Text(
                    "魑魅魍魎",
                    style: TextStyle(fontSize: 20),
                  ),
            TextButton(
                onPressed: () => print("ボタンが押されたよい！"),
                child: const Text("ボタンやろって！")),
            IconButton(
              icon: const Icon(FontAwesomeIcons.apple),
              color: Colors.blue,
              iconSize: 40,
              onPressed: () async => _launchUrl(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(children: [
                SizedBox(
                    child: LinearProgressIndicator(
                  value: _progressValue, // 🚧改造したるぞ
                  minHeight: 40.0,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  backgroundColor: Colors.blue,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${(_progressValue * 100).toStringAsFixed(1).padLeft(4, '0')} %',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: Icon(
                  FontAwesomeIcons.calendar,
                  color: Colors.lightBlue[300],
                  size: 30.0,
                ),
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2005, 1, 1),
                      maxTime: DateTime(2104, 12, 31), onConfirm: (date) {
                    setState(() {
                      targetDay = date;
                    });
                  }, currentTime: targetDay, locale: LocaleType.jp);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                '${targetDay.year} / ${targetDay.month} / ${targetDay.day}',
                style: const TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.teal[100]),
                  ),
                  onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const Page2(
                        title: "TestPages",
                      );
                    }))
                  },
                  child: const Text(
                    'Go to TestPage(PageView).',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          _incrementCounter(),
          _getProgress(),
        },
        tooltip: 'Increment',
        child: const Icon(Icons.timer_10),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(
          child: ListView(children: <Widget>[
        const DrawerHeader(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(color: Colors.blue),
          child: Text(
            "Drawer Header\n2行目",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () => print("ホームが押されたよ"),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Settings"),
          onTap: () => print("設定が押されたよ"),
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Infomation"),
          onTap: () => print("インフォが押されたよ"),
        ),
      ])),
      endDrawer: Drawer(
          child: ListView(children: <Widget>[
        SwitchListTile(
          title: Text("switch"),
          value: _myfeeling,
          onChanged: (bool _v) => {
            _changeMyFeeling(),
            print('value: ${_v}'),
          },
        ),
        Text(
          (_myfeeling) ? "Happy 😻😻😻" : "F**k 😾👎🤮",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ])),
    );
  }
}
