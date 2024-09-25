import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import 'user.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(users: [])) {
    on<AddUser>((event, emit) {
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: event.name,
        jobs: event.jobs,
      );
      final updatedUsers = List<User>.from(state.users)..add(newUser);
      emit(TodoState(users: updatedUsers));
    });
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  void _onUpdateUser(UpdateUser event, Emitter<TodoState> emit) {
    final updatedUsers = state.users.map((user) {
      return user.id == event.user.id ? event.user : user;
    }).toList();
    emit(TodoState(users: updatedUsers));
  }

  void _onDeleteUser(DeleteUser event, Emitter<TodoState> emit) {
    final updatedUsers = state.users.where((user) => user.id != event.userId).toList();
    emit(TodoState(users: updatedUsers));
  }
}
