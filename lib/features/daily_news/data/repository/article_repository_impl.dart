import 'package:dio/dio.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

import '../data_sources/remote/news_api_service.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);
  @override
  Future<DataState<List<ArticleModel>>> getArticles() async {
    try {
      final httpResponse = await _newsApiService.getArticles(
        apiKey: newsApiKey,
        country: country,
        category: category,
      );
      if (httpResponse.response.statusCode == 200) {
        final dynamic articlesData = httpResponse.response.data['articles'];

        if (articlesData is List<dynamic>) {
          // Map the dynamic List to a List of ArticleModel using the fromJson factory method
          final List<ArticleModel> articleModels = articlesData
              .map((dynamic json) =>
                  ArticleModel.fromJson(json as Map<String, dynamic>))
              .toList();


          return DataSuccess(articleModels);
        } else {
          // Handle the case where articlesData is not a List

          return DataFailed(DioException(
            error: 'articlesData is not a List',
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          ));
        }
      } else {

        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<List<ArticleModel>> getArticlesFromLocal() {
    return _appDatabase.articleDao.getAllArticles();
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
