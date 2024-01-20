

import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticleEvent extends Equatable {
  const LocalArticleEvent({this.articleEntity});
  final ArticleEntity? articleEntity;

  @override
  List<Object> get props => [articleEntity!];
}

class GetSavedArticle extends LocalArticleEvent {
  const GetSavedArticle();
}

class DeleteArticle extends LocalArticleEvent {
  const DeleteArticle(ArticleEntity articleEntity) : super(articleEntity: articleEntity);
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(ArticleEntity articleEntity) : super(articleEntity: articleEntity);
}