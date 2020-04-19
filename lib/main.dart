import 'package:flutter/material.dart';

import 'models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: true));
    items.add(Item(title: "Item 3", done: false));
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskController = TextEditingController();

  void add() {
    if (taskController.text.isEmpty) {
      return;
    }
    setState(() {
      widget.items.add(Item(title: taskController.text, done: false));
      taskController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextFormField(
        controller: taskController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Montserrat",
        ),
        decoration: InputDecoration(
          labelText: "Nova Tarefa",
          labelStyle: TextStyle(color: Colors.white),
        ),
      )),
      body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.items[index];
            return CheckboxListTile(
              title: Text(item.title),
              key: Key(item.title),
              value: item.done,
              onChanged: (bool value) {
                setState(() {
                  item.done = value;
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
