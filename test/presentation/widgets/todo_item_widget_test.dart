import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app_testing_starter/cubits/todo_cubit.dart';
import 'package:notes_app_testing_starter/data/models/todo.dart';
import 'package:notes_app_testing_starter/presentation/widgets/todo_item_widget.dart';

import '../screens/todo_screen_test.mocks.dart';

void main() {

  late TodosCubit mockTodosCubit;

  setUp(() {
    mockTodosCubit = MockTodosCubit();
  });

  group('Todo Item Widget', () {

    final todo =  Todo(id: 1, title: 'Gym');

    testWidgets('display todo title is correct', (tester) async {

      // Act
      await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<TodosCubit>.value(
              value: mockTodosCubit,
              child: Scaffold(body: TodoItemWidget(todo: todo)),
            ),
          )
      );

      // Assert
      expect(find.text('Gym'), findsOneWidget);
      final checkbox = find.byType(Checkbox);
      expect(tester.widget<Checkbox>(checkbox).value, false);



    });


    testWidgets('tapping checkbox toggle todo status', (tester) async {

      // Act
      await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<TodosCubit>.value(
              value: mockTodosCubit,
              child: Scaffold(body: TodoItemWidget(todo: todo)),
            ),
          )
      );

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // Assert
      verify(mockTodosCubit.toggleTodoStatus(todo)).called(1);
    });

    testWidgets('delete todo', (tester) async {

      // Act
      await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<TodosCubit>.value(
              value: mockTodosCubit,
              child: Scaffold(body: TodoItemWidget(todo: todo)),
            ),
          )
      );

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Assert
      verify(mockTodosCubit.deleteTodo(1)).called(1);
    });

  });
}