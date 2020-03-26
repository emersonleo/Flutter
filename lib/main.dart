import 'package:flutter/material.dart';
void main(){
  runApp(new HelloWorldScreen());
}

class HelloWorldScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child:Text('Tela Inicial')),
        ),
        body: Center(child: Text("Hello World"),),
      ),
    );
  }

} 