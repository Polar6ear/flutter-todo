import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';
import 'package:todo/util/dialog_box.dart';
import 'package:todo/util/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  // Add this line to define and initialize _myBox

  @override
  void initState(){
    // if this is the first time ever opening the app, then create default data

    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
      }else{
        // there already exists data
        db.loadData();
      }
    super.initState();
  }
  final _controller = TextEditingController();
  // check box was tapped
  void checkBoxChanged(bool? value, int index){
    setState((){
      db.toDoList[index][1] = !db.toDoList[index][1];
  });
  db.updateDatabase();
  }


  // save new task
  
  void saveNewTask(){
    setState((){
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }
  void createNewTask(){
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller:_controller, 
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      }
    );
  }
  // delete task
  void deleteTask(int index){
    setState((){
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        }
      )
    );
  }
}