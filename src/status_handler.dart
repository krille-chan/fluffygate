import 'package:shelf/shelf.dart';

import 'config.dart';

Future<Response> statusHandler(Request request, Config config) async {
  final html = '''
<!doctype html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="container space-y-8 mx-auto h-screen w-screen flex flex-col justify-center items-center">
    <h1 class="block text-5xl">🚀</h1>
    <p><b>${config.appName}</b> is up and running.</p>
    <a href="${config.appWebsite}"
        class="bg-transparent hover:bg-indigo-500 text-indigo-700 transition-colors font-semibold hover:text-white py-2 px-4 border border-indigo-500 hover:border-transparent rounded-xl">
        Install FluffyChat
    </a>
    <span>
        <a class="text-indigo-500 hover:text-indigo-700 underline"
            href="https://github.com/krille-chan/fluffygate">Source
            Code</a> -
        <a class="text-indigo-500 hover:text-indigo-700 underline"
            href="https://github.com/krille-chan/fluffygate/blob/main/LICENSE">License</a> -
        <a class="text-indigo-500 hover:text-indigo-700 underline"
            href="https://matrix.org">About [matrix]</a>
    </span>
</body>

</html>
''';

  const headers = {'Content-Type': 'text/html'};

  return Response.ok(html, headers: headers);
}
