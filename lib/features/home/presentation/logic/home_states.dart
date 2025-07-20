abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class CounterOneState extends HomeStates {}

class CounterTwoState extends HomeStates {}

class ResetState extends HomeStates {}

class FetchUserState extends HomeStates {}

class ChangeThemeState extends HomeStates {}

class GetTopHeadlinesLoadingState extends HomeStates {}

class GetTopHeadlinesErrorState extends HomeStates {
  final String error;

  GetTopHeadlinesErrorState({
    required this.error,
  });
}

class GetTopHeadlinesSuccessState extends HomeStates {}

class LoadingState extends HomeStates {}

class ErrorState extends HomeStates {
  final String error;

  ErrorState({
    required this.error,
  });
}

class SuccessState extends HomeStates {}

class ChangeSelectedIndexState extends HomeStates {}
