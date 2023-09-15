import 'package:shelf/shelf.dart';

Future<Response> notFoundHandler(Request _) async => Response.notFound(
      '{"errcode":"M_UNRECOGNIZED","error":"Unrecognized request"}',
      headers: {'Content-Type': 'application/json'},
    );
