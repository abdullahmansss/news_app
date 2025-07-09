import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/remote/api_endpoints.dart';
import 'package:news_app/core/network/remote/dio_helper.dart';
import 'package:news_app/features/home/data/everything_model.dart';
import 'package:news_app/features/home/presentation/logic/home_states.dart';
import 'package:news_app/main.dart';

HomeCubit homeCubit = HomeCubit.get(navigatorKey.currentContext!);

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  // to access the cubit from anywhere in the app
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;

  void changeTheme() {
    isDark = !isDark;
    emit(ChangeThemeState());
  }

  void getTestDio() async {
    emit(LoadingState());

    final result = await DioHelper.get(
      path: everythingEndpoint,
      search: 'iphone',
      params: {
        'searchIn': 'title,content',
      },
    );

    result.fold(
      (l) {
        emit(
          ErrorState(
            error: l,
          ),
        );
      },
      (r) {
        EverythingModel everythingModel = EverythingModel.fromMap(r);

        debugPrint(everythingModel.status);
        debugPrint(everythingModel.totalResults.toString());
        debugPrint(everythingModel.articles?.length.toString());

        emit(
          SuccessState(),
        );
      },
    );
  }

  EverythingModel? topHeadlinesModel;

  void getTopHeadlines() async {
    topHeadlinesModel = null;

    emit(GetTopHeadlinesLoadingState());

    final result = await DioHelper.get(
      path: topHeadlinesEndpoint,
      params: {
        'country': 'us',
        'category': 'technology',
      },
    );

    result.fold(
      (l) {
        emit(
          GetTopHeadlinesErrorState(
            error: l,
          ),
        );
      },
      (r) {
        topHeadlinesModel = EverythingModel.fromMap(r);

        debugPrint(topHeadlinesModel!.status);
        debugPrint(topHeadlinesModel!.totalResults.toString());
        debugPrint(topHeadlinesModel!.articles?.length.toString());

        emit(
          GetTopHeadlinesSuccessState(),
        );
      },
    );
  }
}
