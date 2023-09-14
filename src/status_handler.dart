import 'package:shelf/shelf.dart';

Future<Response> statusHandler(Request request) async {
  return Response.ok('FluffyGate is up and running :-)');
}
