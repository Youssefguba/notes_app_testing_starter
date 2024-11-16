import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app_testing_starter/cubits/todo_cubit.dart';
import 'package:notes_app_testing_starter/data/models/todo.dart';
import 'package:notes_app_testing_starter/presentation/screens/todo_screen.dart';

import 'todo_screen_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TodosCubit>()
])
void main() {
  late TodosCubit mockTodosCubit;

  setUp(() {
    mockTodosCubit = MockTodosCubit();
  });

  group('Todo Screen', () {

    testWidgets('Display no todos when state is empty', (WidgetTester tester) async {
      // Arrange
      when(mockTodosCubit.state).thenReturn(TodosState([]));


      // Act
      await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<TodosCubit>.value(
              value: mockTodosCubit,
              child: TodosScreen(),
            ),
          )
      );

      // Assert
      expect(find.text('No todos yet!'), findsOneWidget);
    });



    testWidgets('Display todos when state has list of todos', (WidgetTester tester) async {
      // Arrange
      final todosList = [
        Todo(id: 1, title: 'Gym'),
        Todo(id: 2, title: 'Quran'),
        Todo(id: 3, title: 'Book'),
      ];

      when(mockTodosCubit.state).thenReturn(TodosState(todosList));


      // Act
      await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<TodosCubit>.value(
              value: mockTodosCubit,
              child: TodosScreen(),
            ),
          )
      );

      // Assert
      expect(find.text('Gym'), findsOneWidget);
      expect(find.text('Quran'), findsOneWidget);
      expect(find.text('Book'), findsOneWidget);
    });



  });
}