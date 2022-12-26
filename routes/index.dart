import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart' as db;
import 'package:shared/shared.dart';
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = context.read<Database>();
  final user = await db.users.queryUser(1);

  if (user == null) {
    return Response(body: 'Dude there is no one', statusCode: 400);
  }
  {
    final sharedUser = User.fromDB(user);
    return Response(
      body: jsonEncode(sharedUser.toJson()),
    );
  }
}
