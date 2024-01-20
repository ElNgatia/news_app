import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticleState extends Equatable {
  const LocalArticleState({this.articles});
  final List<ArticleEntity>? articles;

  @override
  List<Object> get props => [articles!];
}

final class LocalArticleLoading extends LocalArticleState {
  const LocalArticleLoading();
}

final class LocalArticleDone extends LocalArticleState {
  const LocalArticleDone(List<ArticleEntity> articles) : super(articles: articles);
}
