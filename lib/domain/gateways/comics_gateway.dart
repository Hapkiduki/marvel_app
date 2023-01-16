import 'package:marvel_app/domain/models/comic.dart';

abstract class ComicsGateway {
  Future<List<Comic>> getComics();
}
