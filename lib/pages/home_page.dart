import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List  items =[];
  @override
  void initState() {
    // TODO: implement initState
    fetchTodoData();
    super.initState();
  }
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
      body:ListView.builder(
        itemBuilder: (context,index)
        {
          final item = items[index] as Map;
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(item['title']),
              subtitle: Text(item['description']),
            ),
          );
        },
        itemCount: items.length,
      ),
    );
  }

  Future<void> fetchTodoData()async {
    String url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      var json = jsonDecode(responce.body) as Map;
      print(responce.body);
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      print("Something wrong");
    }
  }

  }
