import 'dart:async';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  return Response(body: 'welcome to loks api!');
}