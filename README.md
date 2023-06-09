# response_x

[![pub package](https://img.shields.io/pub/v/response_x.svg)](https://pub.dartlang.org/packages/response_x)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

library for exchanging response [JSON](https://en.wikipedia.org/wiki/JSON) between server and client. it can be a useful tool for standardizing the way that a server communicates with its clients.

# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  response_x: 1.0.0
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```
$ pub get
```

with `Flutter`:

```
$ flutter pub get
```

### 3. Import it

Now in your `Flutter` code, you can use:

```dart
import 'package:response_x/response_x.dart';
```

### 4. Getting Started

Import the library.

```dart
import 'package:response_x/response_x.dart';
```

```dart
final response = Response.success();
print(response.statusCode); // 200
print(response.message); // OK
print(response.data); // null
print(response.success); // true
```

### 5. Example

[lib/example.dart](https://github.com/ravikovind/response_x/tree/main/example/lib/example.dart)

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:response_x/response_x.dart' as res;

Future<res.Response> todos() async {
  try {
    final uri = Uri.parse(kURI);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final todos = List<TODO>.from(
        json.decode(response.body)?.map((x) => TODO.fromJson(x)) ?? <TODO>[],
      );
      return res.Response.success(
        data: todos,
        message: 'Todos fetched successfully',
      );
    } else {
      return res.Response.failure(
        message: 'There was an error fetching todos',
      );
    }
  } on Exception catch (_) {
    return res.Response.failure(
      message: 'There was an error fetching todos : $_',
    );
  }
}

Future<res.Response> todoById(int id) async {
  try {
    final uri = Uri.parse('$kURI/$id');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final todo = TODO.fromJson(json.decode(response.body));
      return res.Response.success(
        data: todo,
        message: 'Todo fetched successfully',
      );
    } else {
      return res.Response.failure(
        message: 'There was an error fetching todo',
      );
    }
  } on Exception catch (_) {
    return res.Response.failure(
      message: 'There was an error fetching todo : $_',
    );
  }
}

const kBaseURL = 'https://jsonplaceholder.typicode.com';
const kTodosPath = '/todos';
const kURI = '$kBaseURL$kTodosPath';

class TODO {
  TODO({
    required this.id,
    required this.title,
    required this.completed,
  });

  final int id;
  final String title;
  final bool completed;

  factory TODO.fromJson(Map<String, dynamic> json) {
    final id = int.tryParse('${json['id']}') ?? 0;
    final title = json['title']?.toString() ?? 'Not Provided';
    final completed = '${json['completed']}' == 'true';
    return TODO(
      id: id,
      title: title,
      completed: completed,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
      };

  @override
  String toString() => '${toJson()}';
}
```

[bin/example.dart](https://github.com/ravikovind/response_x/tree/main/example/bin/example.dart)

```dart
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
```

# Maintainers

[@ravikovind](https://ravikovind.github.io/)
