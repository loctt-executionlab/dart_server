import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context) async {
  // return _post(context);
  //use to generate data;
  return Response();
}

Future<Response> _post(RequestContext context) async {
  try {
    final database = context.read<Database>();

    await database.foods.insertOne(
      FoodInsertRequest(
        name: 'Pizza Express Margherita',
        imageUrl:
            'https://www.themealdb.com/images/media/meals/x0lk931587671540.jpg',
        descriptionShort: 'Just pizza',
        descriptionExtended:
            'The pizza-est pizza. Not sure what express mean tho.',
        price: 19.99,
      ),
    );

    await database.foodAddons.insertMany([
      FoodAddonInsertRequest(
        foodId: 5,
        name: 'More cheese',
        description: 'cheese!',
        price: 5.99,
      ),
      FoodAddonInsertRequest(
        foodId: 5,
        name: 'Even more cheese!',
        description: 'cheese!!',
        price: 9.99,
      ),
    ]);

    return Response(
      body: 'ok',
    );
  } catch (exception) {
    return Response(
      body: exception.toString(),
      statusCode: HttpStatus.badRequest,
    );
  }
}
