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

final response = Response.failure();
print(response.statusCode); // 400
print(response.message); // failure
print(response.data); // null
print(response.success); // false
```

### 5. Example

```dart
import 'package:response_x/response_x.dart';
import 'package:http/http.dart' as http;

Future<Response> todos() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/todos');
  if (response.statusCode == 200) {
    return Response.success(data: response.body, message: "todos fetched successfully");
  } else {
    return Response.error(message: 'there was an error fetching todos');
  }
}


void main() async {
  final response = await todos();
  if (response.success) {
    print(response.data);
  } else {
    print(response.message);
  }
}

```

# Maintainers
[@ravikovind](https://ravikovind.github.io/)
