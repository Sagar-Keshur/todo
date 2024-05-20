import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/error_state.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/repositories/task_repository.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState());

  final TaskRepository repository = TaskRepository();

  Future<void> fetch() async {
    emit(state.copyWith(taskState: _TaskState.loading));
    List<Task> data = await repository.fetch();
    emit(state.copyWith(taskState: _TaskState.none, tasks: data));
  }

  void addTask({required MainTask task}) {
    List<MainTask> subTask = List<MainTask>.from(state.subTask);
    subTask.add(task);
    emit(state.copyWith(subTask: subTask));
  }

  void doneTask(int index, bool value) {
    List<MainTask> subTask = List<MainTask>.from(state.subTask);

    MainTask task = subTask.elementAt(index).copyWith(isCompleted: value);

    subTask[index] = task;

    emit(state.copyWith(subTask: subTask));
  }

  void remove(int index) {
    List<MainTask> subTask = List<MainTask>.from(state.subTask);

    subTask.removeAt(index);

    emit(state.copyWith(subTask: subTask));
  }

  Future<void> addToDb(String title) async {
    if (state.subTask.isNotEmpty) {
      List<Task> tasks = List<Task>.from(state.tasks);

      Task task = Task(title: title, subTask: state.subTask);

      tasks.add(task);

      emit(state.copyWith(taskState: _TaskState.none, subTask: [], tasks: tasks));

      await repository.create(task);
    }
  }

  Future<void> updateTaskStatus({required int mainIndex, required int index, required bool value}) async {
    List<Task> tasks = List<Task>.from(state.tasks);

    Task task = tasks.elementAt(mainIndex);

    List<MainTask> subTasks = task.subTask ?? [];

    if (subTasks.isNotEmpty) {
      MainTask mainTask = subTasks.elementAt(index).copyWith(isCompleted: value);

      subTasks[index] = mainTask;

      tasks[mainIndex] = task.copyWith(subTask: subTasks);
    }

    emit(state.copyWith(tasks: tasks, taskState: _TaskState.none));
    await repository.update(task);
  }

  @override
  void emit(HomeState state) {
    if (!isClosed) super.emit(state);
  }

  void updateIsAdding(bool value) {
    emit(state.copyWith(isAdding: value, taskState: _TaskState.none));
  }

  void updateIsAllowed(bool value) {
    emit(state.copyWith(isAllowed: value, taskState: _TaskState.none));
  }
}
