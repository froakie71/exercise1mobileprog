import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final List<String> jobs;

  User({required this.id, required this.name, required this.jobs});

  User copyWith({String? name, List<String>? jobs}) {
    return User(
      id: this.id,
      name: name ?? this.name,
      jobs: jobs ?? this.jobs,
    );
  }

  // Add these methods for proper equality checks
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          listEquals(jobs, other.jobs);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ jobs.hashCode;
}
