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
