import 'dart:convert';
import 'dart:io';

import 'package:api_todo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class EditTodo extends StatefulWidget {
  final Map? todo;
  const EditTodo({
    super.key,
    this.todo
  });
  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    final todo = widget.todo;
    if(todo!=null){
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }else{
      print('No value');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: 'Title'
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              maxLines: 10,
              minLines: 6,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              updateData();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
                child: Text('Update')),
          ],
        ),
      ),
    );
  }

  Future<void> updateData()async{
    final title = titleController.text;
    final description = descriptionController.text;
    final todo = widget.todo;
    final id = todo!['_id'] as String;
    print("idddddddddddddd${id}");
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = 'https://api.nstack.in/v1/todos/$id';
    final responce = await http.put(Uri.parse(url),body: jsonEncode(body),headers: {'Content-Type':'application/json'});
    print(responce.statusCode);
    if(responce.statusCode==200){
      showMsg('Create Successfully', Colors.white);
      print(responce.body);
    }else{
      showMsg('Something wrong,pls try again',Colors.red);
    }
  }
  void showMsg(String message,Color color){
    final snackBar = SnackBar(content: Text(message),backgroundColor: color,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
