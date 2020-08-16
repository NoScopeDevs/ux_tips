import 'package:flutter/material.dart';

import 'samples.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UX Improvements',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({Key key}) : super(key: key);

  @override
  __HomeState createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    // * tip 1: use WillPopScope to handle back button on Android
    return WillPopScope(
      onWillPop: _handleBackPress,
      child: Scaffold(
        appBar: AppBar(title: Text('UX Improvements')),
        body: _SamplesList(),
      ),
    );
  }

  Future<bool> _handleBackPress() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sure you want to leave?'),
        actions: [
          FlatButton(
            child: Text('Yes'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}

class _SamplesList extends StatelessWidget {
  const _SamplesList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: samples.length,
        itemBuilder: (context, i) {
          return RaisedButton(
            child: Text(samples[i].toString()),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => samples[i]),
            ),
          );
        },
      ),
    );
  }
}
