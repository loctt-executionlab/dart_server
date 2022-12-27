import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:shared/shared.dart' as domain;
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

    final result = domain.User.fromJson(decodedMap);

    await database.users.insertOne(
      UserInsertRequest(
        email: result.email,
        password: result.password,
        name: result.name,
        phoneNumber: '',
      ),
    );

    return Response(
      body: 'success',
    );
  } catch (exception) {
    return Response(
      body: exception.toString(),
      statusCode: HttpStatus.badRequest,
    );
  }

  // final user = await db.users.queryUser(1);
  // if (user != null) {
  //   final result = User.fromDB(user);
  //   return Response(body: jsonEncode(result));
  // }
}
