import 'article_model.dart';

class MainApiModel {
  MainApiModel({
    this.status,
    this.totalResults,
    this.articles,
    this.message,
  });

  final String? status;
  final int? totalResults;
  final List<Article>? articles;
  final String? message;

  factory MainApiModel.fromJson(Map<String, dynamic> json) => MainApiModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? null
            : List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x))),
      );
}
