import 'package:marvel_app/domain/gateways/comics_gateway.dart';
import 'package:marvel_app/domain/models/comic.dart';

class ComicUsecase {
  final ComicsGateway _comicsGateway;

  const ComicUsecase(this._comicsGateway);

  Future<List<Comic>> getComics() async {
    return await _comicsGateway.getComics();
  }
}
