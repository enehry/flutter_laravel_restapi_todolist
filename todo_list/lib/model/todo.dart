class Todo {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;
  final bool isDone;

  Todo(
      {this.id,
      this.title,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.isDone});

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
        id: data['id'],
        title: data['title'],
        content: data['content'],
        isDone: data['is_done'] == 1 ? true : false,
        createdAt: data['created_at'],
        updatedAt: data['updated_at']);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'created_at': createdAt,
        'update_at': updatedAt,
        'is_done': isDone,
      };
}
