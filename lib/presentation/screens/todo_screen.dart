import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/todo_cubit.dart';
import '../widgets/todo_item_widget.dart';
import '../../data/models/todo.dart';

class TodosScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodosCubit, TodosState>(
              builder: (context, state) {
                if (state.todos.isEmpty) {
                  return const Center(child: Text('No todos yet!'));
                }
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return TodoItemWidget(todo: todo);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Add Todo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                  ),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      final Random random = Random();
                      final int id = random.nextInt(100000);

                      final todo = Todo(
                        id: id,
                        title: _controller.text,
                      );


                      context.read<TodosCubit>().addTodo(todo);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
