import 'package:test/test.dart';

import 'package:response_x/response_x.dart';

void main() {
  group('Response', () {
    test('Response.success', () {
      final response = Response.success();
      expect(response.success, true);
      expect(response.statusCode, 200);
      expect(response.message, 'ok');
      expect(response.data, null);
    });
    test('Response.redirect', () {
      final response = Response.redirect();
      expect(response.success, true);
      expect(response.statusCode, 302);
      expect(response.message, 'redirect');
      expect(response.data, null);
    });
    test('Response.failure', () {
      final response = Response.failure();
      expect(response.success, false);
      expect(response.statusCode, 400);
      expect(response.message, 'failure');
      expect(response.data, null);
    });
    test('Response.status', () {
      final listOfCodes = [
        100,
        200,
        201,
        202,
        203,
        204,
        205,
        206,
        207,
        208,
        226,
        300,
        301,
        302,
        303,
        304,
        305,
        306,
        307,
        308,
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
        410,
        411,
        412,
        413,
        414,
        415,
        416,
        417,
        418,
        421,
        422,
        423,
        424,
        425,
        426,
        428,
        429,
        431,
        451,
        500,
        501,
        502,
        503,
        504,
        505,
        506,
        507,
        508,
        510,
        511,
      ];

      for (final code in listOfCodes) {
        final response = Response.status(code);
        final success = code >= 200 && code < 400;
        final message = _kCodeToSuccessAndMessage[code]?[success]?.toString() ??
            'unable to get message for code $code';
        expect(response.success, success);
        expect(response.statusCode, code);
        expect(response.message, message);
        expect(response.data, null);
      }
    });
  });
}

const Map<int, Map<bool, String>> _kCodeToSuccessAndMessage = {
  100: {true: 'continue'},
  101: {true: 'switching protocols'},
  102: {true: 'processing'},
  103: {true: 'early hints'},
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
