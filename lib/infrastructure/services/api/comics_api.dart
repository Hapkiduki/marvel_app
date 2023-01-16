import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/domain/models/comic.dart';
import 'package:marvel_app/infrastructure/helpers/mappers/comic_maper.dart';
import 'package:marvel_app/infrastructure/services/api/marvel_api.dart';

mixin ComicsApi {
  Future<List<Comic>> getComics();
}

class ComicsApiImp implements ComicsApi {
  final MarvelApi api;
  final ComicMapper mapper;

  const ComicsApiImp(this.api, this.mapper);

  @override
  Future<List<Comic>> getComics() async {
    return await api.getApi(
      dotenv.env['COMICS_URL'] as String,
      (value) {
        final data = value['data']['results'];
        return List<Comic>.from(
          data.map(
            (e) => mapper.fromMap(e),
          ),
        );
      },
    );
  }
}
