import 'package:marvel_app/domain/gateways/comics_gateway.dart';
import 'package:marvel_app/domain/models/comic.dart';
import 'package:marvel_app/infrastructure/services/api/comics_api.dart';

class ComicRepository implements ComicsGateway {
  final ComicsApi _comicsApi;

  const ComicRepository(this._comicsApi);

  @override
  Future<List<Comic>> getComics() async {
    return await _comicsApi.getComics();
  }
}
