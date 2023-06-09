import 'dart:convert';

import 'package:api_todo/pages/edit_page.dart';
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
  bool isLoading = true;
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
      body:Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator(),),
        replacement: RefreshIndicator(
          onRefresh: fetchTodoData,
          child: ListView.builder(
            itemBuilder: (context,index)
            {
              final item = items[index] as Map;
              final id = item['_id'] as String;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  trailing: PopupMenuButton(
                    onSelected: (value){
                      if(value=='edit'){
                        navigatorToEditPage(item);
                      }else if(value == 'delete'){
                        deleteById(id);
                      }
                    },
                      itemBuilder: (context){
                    return [
                      PopupMenuItem(child: Text("Edit"),value: 'edit',),
                      PopupMenuItem(child: Text("Delete"),value: 'delete',)
                    ];
                  })
                ),
              );
            },
            itemCount: items.length,
          ),
        ),
      ),
    );
  }

  Future<void> fetchTodoData()async {
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  Future<void> deleteById(String id)async{
    String url = 'https://api.nstack.in/v1/todos/$id';
    final responce = await http.delete(Uri.parse(url));
    if(responce.statusCode==200){
      final filtered = items.where((element) => element['_id'] !=id).toList();
      setState(() {
        items = filtered;
      });
      showMsg("Deleted Successfully", Colors.white);

    }else{
      showMsg("Failed to delete", Colors.red);
      print('Something wrong');
    }

  }

  void navigatorToEditPage(Map item){
    final route =  MaterialPageRoute(builder: (context)=>EditTodo(todo: item,),);
    Navigator.push(context, route);
  }

  void showMsg(String message,Color color){
    final snackBar = SnackBar(content: Text(message),backgroundColor: color,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  }
