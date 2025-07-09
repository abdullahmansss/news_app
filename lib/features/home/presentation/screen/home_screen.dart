import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/text_styles.dart';
import 'package:news_app/core/util/constants/spacing.dart';
import 'package:news_app/features/home/data/article_model.dart';
import 'package:news_app/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app/features/home/presentation/logic/home_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is SuccessState) {
          debugPrint('Success: Data fetched successfully');
        }

        if(state is ErrorState) {
          debugPrint(state.error);
        }

        if(state is GetTopHeadlinesSuccessState) {
          debugPrint('Success: Data fetched successfully');
        }

        if(state is GetTopHeadlinesErrorState) {
          debugPrint(state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Home Screen',
              style: TextStylesManager.bold20,
            ),
          ),
          body: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  if(state is LoadingState) return;

                  homeCubit.getTopHeadlines();
                },
                child: state is LoadingState ? CupertinoActivityIndicator() : const Text(
                  'Increment Counter One',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
