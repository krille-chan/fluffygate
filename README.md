# FluffyGate

Dead simple push gateway for Matrix to Firebase Cloud Messaging written in Dart.

FluffyGate supports two types of messages:
- Notification Messages
- Data Messages

By default FluffyGate sends Notification Messages. To send Data Messages, set
`"data_message": true` in the `additional_properties` of your Matrix pusher. Regardless
of what message type, FluffyGate sends the payload of the push notification in the
`data` field of the push notification to the user's device and sets the priority
to `high` on Android and the `apns-priority` to `10`. You can override this and
other android/apns specific options for Firebase Cloud Messaging in the config file.


## Running Fluffygate

Copy `config.sample.yaml` to `config.yaml` and adjust it to your needs.

### Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart ./config.yaml
Server listening on port 8080
```

### Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t myserver
$ docker run -it -p 8080:8080 myserver
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080
Hello, World!
$ curl http://0.0.0.0:8080/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```
