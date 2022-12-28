import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:shared/shared.dart' as domain;
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context, String message) async {
  if (context.request.method == HttpMethod.get) {
    return _get(context, message);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _get(RequestContext context, String message) async {
  try {
    final requestId = int.parse(message);
    final database = context.read<Database>();

    final restaurant = await database.restaurants.queryBaseView(requestId);

    if (restaurant != null) {
      final result = domain.Restaurant(
        name: restaurant.name,
        id: restaurant.id.toString(),
        imageUrl: restaurant.logoImageUrl,
        shippingTime: restaurant.deliveryTime,
        shippingPrice: restaurant.deliveryFee,
      ).toJson();

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
