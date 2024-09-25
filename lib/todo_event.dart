import 'user.dart';

abstract class TodoEvent {}

class AddUser extends TodoEvent {
  final String name;
  final List<String> jobs;

  AddUser(this.name, this.jobs);
}

class UpdateUser extends TodoEvent {
  final User user;

  UpdateUser(this.user);
}

class DeleteUser extends TodoEvent {
  final String userId;

  DeleteUser(this.userId);
}
