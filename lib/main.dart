
import 'package:flutter/material.dart';
import 'pages.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    win.size = Size(400, 700);
    win.alignment = Alignment.center; //将窗⼝显⽰到中间
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme:
            const AppBarTheme(color: Color.fromARGB(255, 117, 228, 248)),
      ),
      home: MyHomePage(title: 'Oxscript'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var allpages = [
    Page1(
      title: '1',
    ),
    Page2(),
    Page3(),
    Page4()
  ];
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: allpages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: "工作",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.laptop),
            label: "待定",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: "我的",
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
