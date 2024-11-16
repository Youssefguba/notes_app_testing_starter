import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app_testing_starter/data/models/todo.dart';
import 'package:notes_app_testing_starter/data/todo_local_data_source.dart';

import 'todo_local_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HiveInterface>(),
  MockSpec<Box<Todo>>(),
])
void main() {
  late final LocalDataSource localDataSource;
  late final MockHiveInterface mockHiveInterface;
  late final MockBox mockBox;

  // Separate Environment

  // Mocking = Simulation
  // Testing can't be done on I/O operation

  setUp(() async {
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox(); // MockSharedPreference

    // Simulation
    when(mockHiveInterface.openBox('todos')).thenAnswer((_) async => mockBox);

    localDataSource = LocalDataSource(mockBox);
  });

  group('Test Local Data Source', () {
    final gymTodo = Todo(id: 1, title: 'Gym');
    final quranTodo = Todo(id: 2, title: 'Quran');

    test('Get All Todos', () {
      // Simulation --> Mocking
      // when localDataSource was created, add todos to hive mockBox.

      // Isolated Environment

      // Arrange
      when(mockBox.values).thenReturn([
        Todo(id: 1, title: 'Gym'),
        Todo(id: 2, title: 'Quran'),
      ]);

      // Act
      final todos = localDataSource.getTodos();

      // Assert
      expect(todos.length, 2);
    });

    test('Add Todo to Hive', () async {
      // Arrange

      // Act
      await localDataSource.addTodo(gymTodo);

      // Assert
      verify(mockBox.put(gymTodo.id, gymTodo)).called(1);
    });

    test('Delete Todo from Hive', () async {

      when(mockBox.values).thenReturn([gymTodo]);

      await localDataSource.deleteTodo(1);

      verify(mockBox.delete(1)).called(1);
    });

  });
}
