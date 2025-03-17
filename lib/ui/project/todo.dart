import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/ui/todo_bloc.dart';
import 'package:flutter_firebase/ui/todo_event.dart';
import 'package:flutter_firebase/ui/todo_state.dart';
import 'package:flutter_firebase/ui/user.dart';

class MyTodoPage extends StatelessWidget {
  const MyTodoPage({super.key});

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
                decoration: InputDecoration(labelText: 'Jobs (comma-separated)'),
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
                final jobs = jobsController.text.split(',').map((e) => e.trim()).toList();
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
                decoration: InputDecoration(labelText: 'Jobs (comma-separated)'),
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
                final jobs = jobsController.text.split(',').map((e) => e.trim()).toList();
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
