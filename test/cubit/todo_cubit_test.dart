import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app_testing_starter/cubits/todo_cubit.dart';
import 'package:notes_app_testing_starter/data/models/todo.dart';
import 'package:notes_app_testing_starter/data/todo_local_data_source.dart';

import 'todo_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LocalDataSource>()])
void main() {
  late TodosCubit todosCubit;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    todosCubit = TodosCubit(mockLocalDataSource);
  });

  group('Todo Cubit', () {
    final quranTodo = Todo(id: 1, title: 'Quran');

    blocTest<TodosCubit, TodosState>(
      'emits updated state when todo is added',
      build: () {
        when(mockLocalDataSource.getTodos()).thenReturn([
          quranTodo,
        ]);

        return todosCubit;
      },
      act: (cubit) {
        cubit.addTodo(quranTodo);
      },
      expect: () => [
        isA<TodosState>().having((state) => state.todos.length, 'todo length', 1)
      ],
    );

    blocTest<TodosCubit, TodosState>(
      'emit state when todo is deleted',
      build: () {
        return todosCubit;
      },
      act: (cubit) {
        cubit.deleteTodo(1);
      },
      expect: () => [
        isA<TodosState>().having((state) => state.todos.length, 'todos length', 0)
      ],
    );

    blocTest<TodosCubit, TodosState>(
      'emit state when toggle the todo',
      build: () {
        when(mockLocalDataSource.getTodos()).thenReturn([quranTodo]);
        return todosCubit;
      },
      act: (cubit) {
        cubit.toggleTodoStatus(quranTodo);
      },
      expect: () => [
        isA<TodosState>().having((state) => state.todos.first.isCompleted, 'isCompleted', true)
      ],
    );


  });
}
