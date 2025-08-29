import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names, prefer_typing_uninitialized_variables
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key, 
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction
    });

  @override
  Widget build(BuildContext context) {
    return Padding( 
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ]
        ),
      child:Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: taskCompleted, 
                    onChanged: onChanged,
                    activeColor: Colors.black,
                  ),
                  Text(taskName,
                    style: TextStyle(decoration: taskCompleted 
                    ? TextDecoration.lineThrough 
                    : TextDecoration.none,
                    fontSize: 20)),
                ]
              ),
            ),
      )
    );
  }
}