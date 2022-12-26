import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart' as db;
import 'package:shared/shared.dart';
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.post) {
    return _post(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _post(RequestContext context) async {
  final db = context.read<Database>();
  final user = await db.users.queryUser(1);
  if (user != null) {
    final result = User.fromDB(user);
    return Response(body: jsonEncode(result));
  }
  return Response(statusCode: HttpStatus.notFound);
}
