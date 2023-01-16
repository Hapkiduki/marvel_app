class Comic {
  final int? id;
  final int? digitalId;
  final String? title;
  final int? issueNumber;
  final String? variantDescription;
  final String? description;
  final String? modified;
  final String? isbn;
  final String? upc;
  final String? ean;
  final String? issn;
  final int? pageCount;
  final String? resourceUri;

  const Comic({
    this.id,
    this.digitalId,
    this.title,
    this.issueNumber,
    this.variantDescription,
    this.description,
    this.modified,
    this.isbn,
    this.upc,
    this.ean,
    this.issn,
    this.pageCount,
    this.resourceUri,
  });
}
