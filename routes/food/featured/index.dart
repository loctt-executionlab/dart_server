import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:shared/shared.dart' as domain;
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    return _get(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _get(RequestContext context) async {
  try {
    final database = context.read<Database>();

    final foods = await database.foods.queryFoods(
      const QueryParams(
        limit: 4,
      ),
    );

    if (foods.isNotEmpty) {
      return Response(
        body: jsonEncode(
          foods.map(domain.Food.fromDB).map((e) => e.toJson()).toList(),
        ),
      );
    }
    return Response(
      body: 'Something wrong!',
      statusCode: HttpStatus.badRequest,
    );
  } catch (exception) {
    return Response(
      body: exception.toString(),
      statusCode: HttpStatus.badRequest,
    );
  }
}
