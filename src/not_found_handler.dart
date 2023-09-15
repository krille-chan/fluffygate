import 'package:shelf/shelf.dart';

Future<Response> notFoundHandler(Request _) async => Response.ok(
      '{"errcode":"M_UNRECOGNIZED","error":"Unrecognized request"}',
      headers: {'Content-Type': 'application/json'},
    );
