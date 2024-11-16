import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_testing_starter/data/models/todo.dart';
import 'package:notes_app_testing_starter/data/todo_local_data_source.dart';

part 'todo_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final LocalDataSource localDataSource;

  TodosCubit(this.localDataSource) : super(TodosState(localDataSource.getTodos()));

  void addTodo(Todo todo) async {
    await localDataSource.addTodo(todo);
    emit(TodosState(localDataSource.getTodos()));
  }

  void toggleTodoStatus(Todo todo) async {
    todo.isCompleted = !todo.isCompleted;
    await localDataSource.updateTodo(todo);
    emit(TodosState(localDataSource.getTodos()));
  }

  void deleteTodo(int id) async {
    await localDataSource.deleteTodo(id);
    emit(TodosState(localDataSource.getTodos()));
  }
}