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

    final restaurants = await database.restaurants.queryBaseViews(
      const QueryParams(
        limit: 4,
      ),
    );

    final result = restaurants
        .map(
          (e) => domain.Restaurant(
            name: e.name,
            imageUrl: e.logoImageUrl,
            shippingTime: e.deliveryTime,
            shippingPrice: e.deliveryFee,
          ).toJson(),
        )
        .toList();

    if (result.isNotEmpty) {
      return Response(
        body: jsonEncode(
          result,
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
      statusCode: HttpStatus.internalServerError,
    );
  }
}
