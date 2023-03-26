import 'package:example/example.dart' as example;

Future<void> main() async {
  /// [resultTodos] is of type `Response`
  final resultTodos = await example.todos();
  print('\x1B[31m${resultTodos.toJson()}\x1B[0m');

  /// [resultTodoById] is of type `Response`
  final resultTodoById = await example.todoById(1);
  print('\x1B[21m${resultTodoById.toJson()}\x1B[0m');
  /*
  {success: true, code: 200, message: Todo fetched successfully, data: {id: 1, title: delectus aut autem, completed: false}}
  */
}
