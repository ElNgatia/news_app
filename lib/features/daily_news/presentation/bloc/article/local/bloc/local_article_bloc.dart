import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/delete_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/bloc/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticleUseCase getSavedArticleUseCase;
  final SaveArticleUseCase saveArticleUseCase;
  final DeleteArticleUseCase deleteArticleUseCase;

  LocalArticleBloc(this.getSavedArticleUseCase, this.saveArticleUseCase,
      this.deleteArticleUseCase)
      : super(const LocalArticleLoading()){
    on<GetSavedArticle>(onGetSavedArticle);
    on<SaveArticle>(onSaveArticle);
    on<DeleteArticle>(onDeleteArticle);
      }

  void onGetSavedArticle(GetSavedArticle event,Emitter<LocalArticleState>emit) async {
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticle(
      SaveArticle event, Emitter<LocalArticleState> emit) async {
    await saveArticleUseCase(params: event.articleEntity!);
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }

  void onDeleteArticle(
      DeleteArticle event, Emitter<LocalArticleState> emit) async {
    await deleteArticleUseCase(params: event.articleEntity!);
    final articles = await getSavedArticleUseCase();
    emit(LocalArticleDone(articles));
  }
}
