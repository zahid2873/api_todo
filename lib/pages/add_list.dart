import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
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
              controller: descriptionController,
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

            },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
