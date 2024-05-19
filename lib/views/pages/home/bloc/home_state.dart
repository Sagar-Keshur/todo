// ignore_for_file: library_private_types_in_public_api

part of 'home_bloc.dart';

enum _TaskState { none, loading, succeeded, failed }

class HomeState extends Equatable {
  final List<Task> tasks;

  final List<MainTask> subTask;
  final _TaskState taskState;
  final ErrorState<String> errorState;

  const HomeState({
    this.tasks = const [],
    this.subTask = const [],
    this.taskState = _TaskState.none,
    this.errorState = const ErrorState(error: ''),
  });

  HomeState copyWith({
    List<Task>? tasks,
    List<MainTask>? subTask,
    _TaskState? taskState,
    ErrorState<String>? errorState,
  }) {
    return HomeState(
      subTask: subTask ?? this.subTask,
      tasks: tasks ?? this.tasks,
      taskState: taskState ?? this.taskState,
      errorState: errorState ?? this.errorState,
    );
  }

  bool get isLoading => taskState == _TaskState.loading;

  @override
  List<Object?> get props {
    return [
      subTask,
      tasks,
      taskState,
      errorState,
    ];
  }
}
