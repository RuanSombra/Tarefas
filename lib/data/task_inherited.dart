import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result = context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }
  final List<Task> tasklist = [
    Task('Aprender Flutter', 'assets/images/flutter.png', 3),
    Task('Andar de bike', 'assets/images/bike.webp', 2),
    Task('Meditar', 'assets/images/meditar.png', 5),
    Task('Jogar', 'assets/images/jogar.png', 4),
  ];

  void newTask(String name, String photo, int difficulty){
    tasklist.add(Task(name, photo, difficulty));
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.tasklist.length != tasklist.length;
    //comparando a lista anterior ao atual.
  }
}

