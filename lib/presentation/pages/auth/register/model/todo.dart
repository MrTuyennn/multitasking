class Todo {
  const Todo({this.id = '', this.title = '', this.description = ''});

  final String id;
  final String title;
  final String description;

  Todo copyWith({String? newTitle, String? newDescription}) {
    return Todo(
      id: id,
      title: newTitle ?? title,
      description: newDescription ?? description,
    );
  }
}
