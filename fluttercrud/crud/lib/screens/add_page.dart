import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  //receive here
  final Map? todo;
  const AddTodoPage({super.key, this.todo});
//accept here
  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  //reuse for edit
  bool isEdit = false;
  //data hai ya nhi pichla page se aaya toh edit ke liye use
  @override
  void initState() {
    // TODO: implement initState
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  var arrColors = [
    Colors.amber,
    Colors.grey,
    Colors.blue,
    Colors.pink,
    Colors.green,
    Colors.purpleAccent,
    Colors.brown,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            isEdit ? 'Edit Todo' : "Add Todo",
            style: TextStyle(
                color: arrColors[0],
                backgroundColor: arrColors[2],
                fontFamily: 'FontMain',
                fontSize: 15,
                fontWeight: FontWeight.w100),
          ),
        ),
        body: ListView(padding: EdgeInsets.all(20), children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "Description"),
            minLines: 5,
            maxLines: 8,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(isEdit ? "Update" : "Submit"),
            ),
          ),
        ]));
  }

  Future<void> updateData() async {
    //Get the data from form
    final todo = widget.todo;
    if (todo == null) {
      print("you can not call updated without todo data");
      return;
    }
    final id = todo['_id'];
    //final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      //print("successfully created data");
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("updation success");
    } else {
      // print("something error");
      showSuccessMessage("updation failed");
    }
  }

  Future<void> submitData() async {
    //Get the data from the server
    //Submit data to the server
    //show success or fail message based on status
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 201) {
      //print("successfully created data");
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage("successfully created");
    } else {
      // print("something error");
      showSuccessMessage("creation failed");
    }
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: arrColors[7]),
      ),
      backgroundColor: arrColors[3],
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
