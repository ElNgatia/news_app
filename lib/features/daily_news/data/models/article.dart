import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

import '../../../../core/constants/constants.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] != null && map['urlToImage'] != "" ? map['urlToImage'] : kDefaultImage,
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity articleEntity) {
    return ArticleModel(
      id: articleEntity.id,
      author: articleEntity.author,
      title: articleEntity.title,
      description: articleEntity.description,
      url: articleEntity.url,
      urlToImage: articleEntity.urlToImage,
      publishedAt: articleEntity.publishedAt,
      content: articleEntity.content,
    );
  }
}
