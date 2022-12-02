// ignore_for_file: prefer_const_constructors,avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:image/image.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Page1> createState() => Page1state();
}

class Page1state extends State<Page1> {
  late Socket printer;
  var isconnect = 0;
  // ignore: prefer_typing_uninitialized_variables
  var inputcmd;

// #OXScript:response:reqID:labelWidth:labelHeight:pngLen:pngData;md5;terminal output;#End
  // ignore: duplicate_ignore
  onData(event) async {
    final ev = String.fromCharCodes(event);
    var msglist = ev.split(";");
    // print(msglist[6].length);
    var data = msglist[6].toString();
    var img = base64Decode(data);
    var fff = await File('C:/Users/86138/Desktop/111.png').create();
    fff.writeAsBytesSync(img);
    print("preview creat ok!");
  }

  errorcallback(err) => print('error:{$err}');

  done() => print('done!');

  connect() async {
    if (isconnect == 0) {
      await Socket.connect('199.9.10.92', 9000).then((Socket sock) {
        printer = sock;
        print('ip connected!');
        printer.listen(onData,
            onError: errorcallback, onDone: done, cancelOnError: false);
        isconnect = 1;
      }).catchError((e) {
        print("connect failed!");
      });
    }
  }

  cmd() async {
    if (inputcmd != null) {
      printer.add(utf8.encode('#OXScript;run;789;$inputcmd.py;#End\n'));
      print('cmd succeess!');
    } else {
      print("cmd is null");
    }
  }

  close() {
    if (isconnect == 1) {
      printer.close();
      isconnect = 0;
      print('closed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/1.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 100,
                  child: const Text(
                    'CONTROL',
                    style: TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 50,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          // labelText: "请输入文件名",
                          // icon: Icon(Icons.people),
                          hintText: "请输入文件名",
                          hintStyle: TextStyle(color: Colors.black)),
                      style: TextStyle(
                          fontSize: 25,
                          backgroundColor: Colors.white54,
                          fontWeight: FontWeight.bold),
                      maxLength: 20,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        inputcmd = value;
                        print("input msg :$value");
                      },
                      onEditingComplete: () {
                        print("complete");
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.greenAccent),
                      ),
                      onPressed: () async {
                        await connect();
                        print("printer connected!");
                      },
                      child: const Text('Connect',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlueAccent),
                      ),
                      onPressed: () {
                        cmd();
                      },
                      child: const Text('Submit',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                      ),
                      onPressed: () {
                        close();
                      },
                      child: const Text('Close',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            // fontFamily:,
                          ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // appBarTheme: AppBarTheme(color: Color.fromARGB(255, 106, 177, 239)),
      ),
      home: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/1.jpg'), fit: BoxFit.cover),
          ),
          child: const Text('page2')),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.amber),
      ),
      home: const Text('good3'),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Common',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Colors.amber),
      ),
      home: const Text('good4'),
    );
  }
}

var s1 = Container(
  color: Colors.black,
  child: Center(
    child: FutureBuilder(
      future: Future.delayed(Duration(seconds: 4), () => 'Welcome'),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Text(
            "${snapshot.data}",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 50,
            ),
          );
        }
        if (snapshot.hasError) {
          return const Icon(Icons.error, size: 60);
        }
        return CircularProgressIndicator();
      },
    ),
  ),
);
