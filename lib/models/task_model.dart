class Task {
  String? id;
  String? title;
  String? uid;
  List<MainTask>? subTask;
  Task({
    this.id,
    this.title,
    this.uid,
    this.subTask,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'subTask': subTask?.map((x) => x.toMap()).toList(),
      'uid': uid,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      uid: map['uid'],
      subTask: map['subTask'] != null ? List<MainTask>.from((map['subTask']).map<MainTask>((x) => MainTask.fromMap(x))) : null,
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? uid,
    List<MainTask>? subTask,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      uid: uid ?? this.uid,
      subTask: subTask ?? this.subTask,
    );
  }
}

class MainTask {
  bool isCompleted;
  String? value;
  MainTask({
    this.isCompleted = false,
    this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isCompleted': isCompleted,
      'value': value,
    };
  }

  factory MainTask.fromMap(Map<String, dynamic> map) {
    return MainTask(
      isCompleted: map['isCompleted'] ?? false,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  MainTask copyWith({
    bool? isCompleted,
    String? value,
  }) {
    return MainTask(
      isCompleted: isCompleted ?? this.isCompleted,
      value: value ?? this.value,
    );
  }
}
