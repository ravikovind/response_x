import 'package:response_x/response_x.dart';

void main() {
  final codes = <int>[200, 201, 202, 203, 204, 205, 206, 207, 208, 226];
  for (var code in codes) {
    final response = Response.status(code);
    final json = response.json({
      'message': 'this is a $code code response',
    });
    print(json);
  }
  final errorCodes = <int>[
    400,
    401,
    402,
    403,
    404,
    405,
    406,
    407,
    408,
    409,
    500,
    501,
    502,
    503,
    504,
    505
  ];

  for (var code in errorCodes) {
    final response = Response.status(code);
    final json = response.json({
      'message': 'this is a $code code response',
    });
    print('\x1B[31m$json\x1B[0m');
  }
}
