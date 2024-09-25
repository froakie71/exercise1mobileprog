import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobileexercise_2/todo_event.dart';
import 'todo_bloc.dart';
import 'todo_state.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoList(),
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text(user.jobs.join(', ')),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<TodoBloc>().add(DeleteUser(user.id));
                  },
                ),
                onTap: () {
                  // Show dialog to update user info
                  _showUpdateDialog(context, user);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Show dialog to add new user
          _showAddDialog(context);
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final jobsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: jobsController,
                decoration:
                    InputDecoration(labelText: 'Jobs (comma-separated)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final name = nameController.text.trim();
                final jobs = jobsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .toList();
                if (name.isNotEmpty) {
                  context.read<TodoBloc>().add(AddUser(name, jobs));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(BuildContext context, User user) {
    final nameController = TextEditingController(text: user.name);
    final jobsController = TextEditingController(text: user.jobs.join(', '));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: jobsController,
                decoration:
                    InputDecoration(labelText: 'Jobs (comma-separated)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Update'),
              onPressed: () {
                final name = nameController.text.trim();
                final jobs = jobsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .toList();
                if (name.isNotEmpty) {
                  final updatedUser = user.copyWith(name: name, jobs: jobs);
                  context.read<TodoBloc>().add(UpdateUser(updatedUser));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
