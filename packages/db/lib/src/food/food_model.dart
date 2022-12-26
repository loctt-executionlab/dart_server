import 'package:db/src/rating/rating_model.dart';
import 'package:stormberry/stormberry.dart';

@Model()
abstract class Food {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get name;

  String get imageUrl;

  String get descriptionShort;

  String get descriptionExtended;

  double get price;

  List<Rating> get ratings;
}
