import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//=========================================================
// Home

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }

  // State
  var _list = <Data>[];

  void _addItem() {
    // Enviamos una instancia del modelo al stream
    _streamController.sink.add(Data(_nominar(), 0));
    //setState(() {});
  }

  // Un ejemplo de un closure
  // cada vez que se invoca devuelve un valor en ciclo de la lista de valores
  var _nominar = () {
    var i = 0;
    var names = [
      'lunes',
      'martes',
      'miercoles',
      'jueves',
      'viernes',
      // 'sabado',
      // 'domingo'
    ];
    return () => names[i++ % names.length];
  }();

  @override
  Widget build(BuildContext context) {
    var _data = StreamBuilder<Data>(
        stream: _stream,
        builder: (_, AsyncSnapshot<Data> snapshot) {
          print(snapshot.data?.name);
          if (snapshot.data == null) return Text('Todavía nada');
          _list.add(snapshot.data);
          return Column(
            children: [
              for (var item in _list) ...[DataWidget(item: item), Divider()]
            ],
          );
        });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30),
            _data,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// ================================================================
// Widget para presentar el modelo

class DataWidget extends StatefulWidget {
  DataWidget({Key key, this.item}) : super(key: key);
  final Data item;

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  // Los eventos que modifican el estado
  void _incrementCounter(int delta) {
    widget.item.value += delta;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.item.name, style: TextStyle(fontStyle: FontStyle.italic)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
            onPressed: () => _incrementCounter(1),
            icon: Icon(Icons.add),
            color: Colors.green),
        Text(
          '${widget.item.value}',
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(
            onPressed: () => _incrementCounter(-1),
            icon: Icon(Icons.remove),
            color: Colors.red),
      ]),
    ]);
  }
}

// ================================================================
// El modelo
class Data {
  String name;
  int value;
  Data(this.name, this.value);
}

// Y el stream accesibles desde todos los widgets
StreamController<Data> _streamController;
Stream<Data> _stream;
