import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;

//find the correct local path   [get property or function]
  Future<String> get getLocalPath async {
    var folder = await getApplicationDocumentsDirectory();
    // print("my path is : ${folder.path}");
    return folder.path;
  }

//get file
  Future<File> getLocalFile() async {
    String path = await getLocalPath;
    return File('$path/counter.txt');
  }

//write
  void writeCounter(int c) async {
    File file = await getLocalFile();
    file.writeAsString("$c");
  }

//read
  Future<int> readCounter() async {
    try {
      File file = await getLocalFile();
      String content = await file.readAsString();
      return int.parse(content);
    } catch (e) {
      return -1;
    }
  }

  @override
  void initState() {
    readCounter().then((data) {
      setState(() {
        counter = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Path Provider Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "counter is : $counter",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            counter++;
            writeCounter(counter);
          });
        },
      ),
    );
  }
}
