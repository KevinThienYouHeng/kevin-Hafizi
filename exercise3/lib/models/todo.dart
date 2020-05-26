//-----------------------------------------------------------
// Mobile Application Programming (SCSJ3623)
// Semester 2, 2019/2020
// Exercise 3: HTTP and JSON
//
// Name 1:  KEVIN THIEN YOU HENG
// Name 2:  MUHAMMAD HAFIZI BIN MD ZULKEFLEE
//-----------------------------------------------------------

// TODO Complete the definition of class Todo. Add the methods, fromJson() and toJson()

class Todo {
  int id;
  String title;
  bool completed;

  Todo({this.id, this.title, this.completed = false});

  Todo.copy(Todo from)
      : this(id: from.id, title: from.title, completed: from.completed);

  Todo.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'],
            title: json['title'],
            completed: json['completed']);

  Map<String, dynamic> toJson() =>
      {'id': id, 'title': title, 'completed': completed};
}
