import 'package:marvel_app/domain/models/comic.dart';
import 'package:marvel_app/infrastructure/helpers/mappers/base_map.dart';

class ComicMapper extends BaseMapper<Comic> {
  @override
  Comic fromMap(Map<String, dynamic> json) {
    return Comic(
      id: json["id"],
      digitalId: json["digitalId"],
      title: json["title"],
      issueNumber: json["issueNumber"],
      variantDescription: json["variantDescription"],
      description: json["description"],
      modified: json["modified"],
      isbn: json["isbn"],
      upc: json["upc"],
      ean: json["ean"],
      issn: json["issn"],
      pageCount: json["pageCount"],
      resourceUri: json["resourceURI"],
    );
  }

  @override
  Map<String, dynamic> toMap(Comic data, {bool update = false}) {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
