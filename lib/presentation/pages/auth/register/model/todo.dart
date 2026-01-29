class Todo {
  const Todo({this.id = '', this.title = '', this.description = ''});

  final String id;
  final String title;
  final String description;

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Todo copyWith({String? newTitle, String? newDescription}) {
    return Todo(
      id: id,
      title: newTitle ?? title,
      description: newDescription ?? description,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}
