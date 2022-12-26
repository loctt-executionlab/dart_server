import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _post(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _post(RequestContext context) async {
  try {
    final database = context.read<Database>();

    final jsonString = await context.request.body();
    final decodedMap = json.decode(jsonString) as Map<String, dynamic>;

    final email = decodedMap['email'];
    final password = decodedMap['password'];

    final user = await database.users.queryUsers(
      QueryParams(where: "email = '$email' and password = '$password'"),
    );

    if (user.isNotEmpty) {
      return Response(
        body: 'success',
      );
    }
    return Response(
      body: 'invalid username or password',
      statusCode: HttpStatus.badRequest,
    );
  } catch (exception) {
    return Response(
      body: exception.toString(),
      statusCode: HttpStatus.badRequest,
    );
  }
}
