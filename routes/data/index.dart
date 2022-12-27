import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:stormberry/stormberry.dart';

Future<Response> onRequest(RequestContext context) async {
  // return _post(context);
  // use to generate data;
  return Response();
}

Future<Response> _post(RequestContext context) async {
  try {
    final database = context.read<Database>();

    final request = RestaurantInsertRequest(
      name: 'McRonald',
      adress: 'adress',
      deliveryFee: 'free',
      deliveryTime: '20-30 min.',
      bannerImageUrl: '',
      logoImageUrl:
          'https://99designs-blog.imgix.net/blog/wp-content/uploads/2019/04/attachment_85538842-700x700.jpeg',
    );

    await database.tags.insertOne(TagInsertRequest(name: 'Fast Food'));

    await database.restaurants.insertOne(request);

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
