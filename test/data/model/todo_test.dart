import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app_testing_starter/data/models/todo.dart';

void main() {

  group('Todo Model', () {
    /// Global Variables

    const int id = 1;
    const String title = 'Gym';
    final todo = Todo(id: id, title: title);


    test('Test Creating of Todo Object', () {
      // Assert
      expect(todo.id, 1);
      expect(todo.title, 'Gym');
      expect(todo.isCompleted, false);
      expect(todo, isA<Todo>());
    });

    test('Test toggle of completion status of Todo Object', () {
      // Act
      todo.isCompleted = !todo.isCompleted;

      // Assert
      expect(todo.isCompleted, true);
    });
  });
}
