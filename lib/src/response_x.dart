import 'package:equatable/equatable.dart';

/// [Response] is class that represents a server response. class can be a useful tool for standardizing the way that a server communicates with its clients.
class Response extends Equatable {
  /// [Response] constructor. it takes [success], [statusCode], [message] and [data] as parameters. 
  const Response({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  ///success is a [bool] value indicating whether the server operation was successful or not. It can be used to determine whether to proceed with further processing or show an error message to the user.
  final bool success;

  /// statusCode is typically an [int] value that represents the HTTP status code returned by the server. Common status codes include 200 (OK), 400 (Bad Request), 401 (Unauthorized), 404 (Not Found), and 500 (Internal Server Error).
  final int statusCode;

  /// message is a [String] containing a human-readable message that provides more information about the response. For example, if the [success] property is false, the [message] property could contain an error message that describes what went wrong.
  final String message;

  /// data is what the server wants to return to the client. It's a nullable [Object], It could be a [Map], a [List], or a single value such as a [String], [int], or [bool]. also it can be [null].
  final Object? data;

  /// [Response.success] returns a [Response] with [success] set to true and [statusCode] set to 200.
  /// [Response.success] can use for returning successful responses.
  /// generally successful responses are returned with [statusCode] 2xx.
  factory Response.success({
    String message = 'ok',
    Object? data,
  }) =>
      Response(
        success: true,
        statusCode: 200,
        message: message,
        data: data,
      );

  /// [Response.redirect] returns a [Response] with [success] set to true and [statusCode] set to 302.
  /// [message] is set to the provided [message].
  /// [data] is set to the provided [data].
  /// [data] is optional.
  /// [Response.redirect] can use for returning redirect responses.
  /// generally redirect responses are returned with [statusCode] 3xx.

  factory Response.redirect({
    String message = 'redirect',
    Object? data,
    bool success = true,
  }) =>
      Response(
        success: success,
        statusCode: 302,
        message: message,
        data: data,
      );

  /// [Response.failure] returns a [Response] with [success] set to false and [statusCode] set to the provided [statusCode] starting with 4xx or 5xx.
  /// [message] is set to the provided [message].
  /// [data] is set to the provided [data].
  /// [Response.failure] can use for returning failure responses.
  /// generally failure responses are returned with [statusCode] 4xx and 5xx.
  factory Response.failure({
    int statusCode = 400,
    String message = 'failure',
    Object? data,
  }) =>
      Response(
        success: false,
        statusCode: statusCode,
        message: message,
        data: data,
      );

  /// [Response.status] returns a [Response] based on the provided [statusCode].
  ///
  /// Reference: [https://developer.mozilla.org/en-US/docs/Web/HTTP/Status]
  factory Response.status(int code) {
    final success = code >= 200 && code < 400;
    final message = _kCodeToSuccessAndMessage[code]?[success]?.toString() ??
        'unable to get message for code $code';
    return Response(
      success: success,
      statusCode: code,
      message: message,
    );
  }

  /// [Response.json] returns a [Response].
  /// it's used overriding only [data] of the [Response].
  Response json(Object? data) => Response(
        success: success,
        statusCode: statusCode,
        message: message,
        data: data ?? this.data,
      );

  /// [Response.copyWith] returns a [Response] with the provided [success], [statusCode], [message] and [data].
  /// [success] is optional.
  /// [statusCode] is optional.
  /// [message] is optional.
  /// [data] is optional.
  /// it is useful for overriding the [success], [statusCode], [message] and [data] of the [Response].
  Response copyWith({
    bool? success,
    int? statusCode,
    String? message,
    Object? data,
  }) =>
      Response(
        success: success ?? this.success,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  /// [Response.fromJson] returns a [Response] from the provided [json] map of [String] and [dynamic].
  factory Response.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final message = json['message']?.toString() ?? 'internal server error';
    final statusCode = int.tryParse('${json['statusCode']}') ?? 500;
    final success = json['success']?.toString() == 'true';
    return Response(
      success: success,
      statusCode: statusCode,
      message: message,
      data: data,
    );
  }

  /// [Response.toJson] returns a JSON [Map] of representation of the [Response].
  Map<String, dynamic> toJson() => {
        'success': success,
        'code': statusCode,
        'message': message,
        'data': data,
      };

  @override
  List<Object?> get props => [success, statusCode, message, data];

  @override
  String toString() =>
      'Response { success: $success, statusCode: $statusCode, message: $message, data: $data }';
}

/// [_kCodeToSuccessAndMessage] is a [Map] of [int] and [Map] of [bool] and [String].
/// [_kCodeToSuccessAndMessage] contains the [statusCode] and the [success] and the [message] of the response.
const Map<int, Map<bool, String>> _kCodeToSuccessAndMessage = {
  200: {true: 'ok'},
  201: {true: 'created'},
  202: {true: 'accepted'},
  203: {true: 'non-authoritative information'},
  204: {true: 'no content'},
  205: {true: 'reset content'},
  206: {true: 'partial content'},
  207: {true: 'multi-status'},
  208: {true: 'already reported'},
  226: {true: 'im used'},
  300: {true: 'multiple choices'},
  301: {true: 'moved permanently'},
  302: {true: 'redirect'},
  303: {true: 'see other'},
  304: {true: 'not modified'},
  305: {true: 'use proxy'},
  306: {true: 'switch proxy'},
  307: {true: 'temporary redirect'},
  308: {true: 'permanent redirect'},
  400: {false: 'failure'},
  401: {false: 'unauthorized'},
  402: {false: 'payment required'},
  403: {false: 'forbidden'},
  404: {false: 'not found'},
  405: {false: 'method not allowed'},
  406: {false: 'not acceptable'},
  407: {false: 'proxy authentication required'},
  408: {false: 'request timeout'},
  409: {false: 'conflict'},
  410: {false: 'gone'},
  411: {false: 'length required'},
  412: {false: 'precondition failed'},
  413: {false: 'payload too large'},
  414: {false: 'uri too long'},
  415: {false: 'unsupported media type'},
  416: {false: 'range not satisfiable'},
  417: {false: 'expectation failed'},
  418: {false: 'i\'m a teapot'},
  421: {false: 'misdirected request'},
  422: {false: 'unprocessable entity'},
  423: {false: 'locked'},
  424: {false: 'failed dependency'},
  425: {false: 'too early'},
  426: {false: 'upgrade required'},
  428: {false: 'precondition required'},
  429: {false: 'too many requests'},
  431: {false: 'request header fields too large'},
  451: {false: 'unavailable for legal reasons'},
  500: {false: 'internal server error'},
  501: {false: 'not implemented'},
  502: {false: 'bad gateway'},
  503: {false: 'service unavailable'},
  504: {false: 'gateway timeout'},
  505: {false: 'http version not supported'},
  506: {false: 'variant also negotiates'},
  507: {false: 'insufficient storage'},
  508: {false: 'loop detected'},
  510: {false: 'not extended'},
  511: {false: 'network authentication required'},
};
