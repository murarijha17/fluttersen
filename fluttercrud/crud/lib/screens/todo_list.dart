import 'dart:convert';

import 'package:crud/screens/add_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List items = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchTodo();
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
      backgroundColor: arrColors[0],
      appBar: AppBar(
        title: Center(
          child: Text(
            "Todo App",
            style: TextStyle(
                color: arrColors[0],
                backgroundColor: arrColors[2],
                fontFamily: 'FontMain',
                fontSize: 15,
                fontWeight: FontWeight.w100),
          ),
        ),
      ),
      //display data listview builder
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: FetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'] as String;
                return ListTile(
                  //item.toString()
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item['title']),
                  subtitle: Text(item['description']),
                  //edit aur delete
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        //open edit page
                        navigateToEditPage(item);
                      } else if (value == 'delete') {
                        //open delete and remove item
                        deleteById(id);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(child: Text('Edit'), value: 'edit'),
                        PopupMenuItem(child: Text('Delete'), value: 'delete'),
                      ];
                    },
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          label: Text(
            "Add Todo",
            style: TextStyle(
                backgroundColor: arrColors[2],
                color: Colors.white,
                fontFamily: 'FontMain',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item),
      //send next page
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    FetchTodo();
  }

  Future<void> deleteById(String id) async {
    //delete the item
    //remove item from the list
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      //Remove item from the list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage("deletion failed");
      //show error
    }
  }

  Future<void> FetchTodo() async {
    setState(() {
      isLoading = true;
    });
    final url = "https://api.nstack.in/v1/todos?page=1&limit=10";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    // print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        //rerender page
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
