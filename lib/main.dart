import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubits/todo_cubit.dart';
import 'data/models/todo.dart';
import 'data/todo_local_data_source.dart';
import 'presentation/screens/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register the Adapter
  Hive.registerAdapter(TodoAdapter());

  // Open the box
  await Hive.openBox<Todo>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodosCubit(LocalDataSource(Hive.box<Todo>('todos'))),
      child: MaterialApp(
        title: 'Todo App with Cubit',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        home: TodosScreen(),
      ),
    );
  }
}
