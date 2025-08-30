import 'package:hive/hive.dart';

class ToDoDatabase{
  // refference the box
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData(){
    toDoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  // load data from database
  void loadData(){
    toDoList = _myBox.get('TODOLIST');
  }
// update database
  void updateDatabase(){
    _myBox.put('TODOLIST', toDoList);
  }
}