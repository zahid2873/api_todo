import 'dart:convert';
import 'dart:io';

import 'package:api_todo/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class AddTodo extends StatefulWidget {
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

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
              submitData();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }

  Future<void> submitData()async{
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    final url = 'https://api.nstack.in/v1/todos';
    final responce = await http.post(Uri.parse(url),body: jsonEncode(body),headers: {'Content-Type':'application/json'});
    if(responce.statusCode==201){
      descriptionController.text='';
      titleController.text = '';
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
