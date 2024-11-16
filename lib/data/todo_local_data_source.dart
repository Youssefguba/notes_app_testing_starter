import 'package:hive/hive.dart';
import 'models/todo.dart';

// abstract class InterfaceLocalDataSource {
//   List<Todo> getTodos();
//
//   Future<void> addTodo(Todo todo);
//
//   Future<void> updateTodo(Todo todo);
//
//   Future<void> deleteTodo(int id);
// }

class LocalDataSource {
  final Box<Todo> todosBox;

  LocalDataSource(this.todosBox);

  List<Todo> getTodos() {
    return todosBox.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    await todosBox.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await todosBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(int id) async {
    await todosBox.delete(id);
  }


  Future<List<Todo>> deleteTodoAndFetch(int id) async {
    await todosBox.delete(id);
    return todosBox.values.toList();
  }


}
