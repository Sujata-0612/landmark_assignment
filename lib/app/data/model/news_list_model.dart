class NewsListResponse {
  Meta? meta;
  List<Data>? data;

  NewsListResponse({this.meta, this.data});

  NewsListResponse.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  int? found;
  int? returned;
  int? limit;
  int? page;

  Meta({this.found, this.returned, this.limit, this.page});

  Meta.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    returned = json['returned'];
    limit = json['limit'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['found'] = found;
    data['returned'] = returned;
    data['limit'] = limit;
    data['page'] = page;
    return data;
  }
}

class Data {
  String? uuid;
  String? title;
  String? description;
  String? keywords;
  String? snippet;
  String? url;
  String? imageUrl;
  String? language;
  String? publishedAt;
  String? source;
  List<String>? categories;
  String? relevanceScore;
  String? locale;

  Data(
      {this.uuid,
        this.title,
        this.description,
        this.keywords,
        this.snippet,
        this.url,
        this.imageUrl,
        this.language,
        this.publishedAt,
        this.source,
        this.categories,
        this.relevanceScore,
        this.locale});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    title = json['title'];
    description = json['description'];
    keywords = json['keywords'];
    snippet = json['snippet'];
    url = json['url'];
    imageUrl = json['image_url'];
    language = json['language'];
    publishedAt = json['published_at'];
    source = json['source'];
    categories = json['categories'].cast<String>();
    relevanceScore = json['relevance_score'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['title'] = title;
    data['description'] = description;
    data['keywords'] = keywords;
    data['snippet'] = snippet;
    data['url'] = url;
    data['image_url'] = imageUrl;
    data['language'] = language;
    data['published_at'] = publishedAt;
    data['source'] = source;
    data['categories'] = categories;
    data['relevance_score'] = relevanceScore;
    data['locale'] = locale;
    return data;
  }
}