import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  // Api methods
  Future<DataState<List<ArticleEntity>>> getArticles();
// Database methods
  Future<List<ArticleEntity>> getArticlesFromLocal();
  Future<void> saveArticle(ArticleEntity article);
  Future<void> deleteArticle(ArticleEntity article);
}
