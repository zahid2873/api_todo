import 'package:api_todo/pages/add_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTodo()));
      },
      child: Icon(Icons.add,size: 20,),
      ),
    );
  }
}
