import 'package:flutter/foundation.dart';

import 'user.dart';

class TodoState {
  final List<User> users;

  TodoState({required this.users});

  // Add these methods for proper equality checks
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoState &&
          runtimeType == other.runtimeType &&
          listEquals(users, other.users);

  @override
  int get hashCode => users.hashCode;
}
