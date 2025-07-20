import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/network/remote/api_endpoints.dart';
import 'package:news_app/core/network/remote/dio_helper.dart';
import 'package:news_app/features/home/data/everything_model.dart';
import 'package:news_app/features/home/presentation/logic/home_states.dart';
import 'package:news_app/features/home/presentation/widgets/categories_list.dart';
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

  EverythingModel? searchModel;

  void searchNews({
    required String text,
}) async {
    searchModel = null;

    emit(LoadingState());

    final result = await DioHelper.get(
      path: everythingEndpoint,
      search: text.toLowerCase(),
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
        searchModel = EverythingModel.fromMap(r);

        debugPrint(searchModel!.status);
        debugPrint(searchModel!.totalResults.toString());
        debugPrint(searchModel!.articles?.length.toString());

        emit(
          SuccessState(),
        );
      },
    );
  }

  void getTopHeadlines() async {
    searchModel = null;

    emit(LoadingState());

    final result = await DioHelper.get(
      path: topHeadlinesEndpoint,
      params: {
        'country': 'us',
        'category': categories[selectedIndex].toLowerCase(),
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
        searchModel = EverythingModel.fromMap(r);

        debugPrint(searchModel!.status);
        debugPrint(searchModel!.totalResults.toString());
        debugPrint(searchModel!.articles?.length.toString());

        emit(
          SuccessState(),
        );
      },
    );
  }

  TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    getTopHeadlines();
    emit(ChangeSelectedIndexState());
  }
}










