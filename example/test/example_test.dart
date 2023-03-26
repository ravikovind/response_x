import 'package:example/example.dart' as example;

import 'package:test/test.dart';

Future<void> main() async {
  /// [resultTodos] is of type `Response`
  final resultTodos = await example.todos();

  test('Test Todos', () {
    expect(resultTodos.success, true);
    expect(resultTodos.statusCode, 200);
    expect(resultTodos.message, 'Todos fetched successfully');
    expect(resultTodos.data, isNotNull);
    expect(resultTodos.data, TypeMatcher<List<example.TODO>>());
  });

  /// [resultTodoById] is of type `Response`
  final resultTodoById = await example.todoById(1);

  test('Test Todo by id: 1', () {
    final todo = resultTodoById.data as example.TODO;
    expect(resultTodoById.success, true);
    expect(resultTodoById.statusCode, 200);
    expect(resultTodoById.message, 'Todo fetched successfully');
    expect(todo, TypeMatcher<example.TODO>());
  });
}
