import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/text_styles.dart';
import 'package:news_app/core/util/constants/spacing.dart';
import 'package:news_app/features/home/data/article_model.dart';
import 'package:news_app/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app/features/home/presentation/logic/home_states.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchListWidget extends StatelessWidget {
  const SearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is LoadingState || current is ErrorState || current is SuccessState;
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return LoadingSearchListWidget();
        }
        
        if (state is ErrorState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.error,
                textAlign: TextAlign.center,
                style: TextStylesManager.medium16,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemBuilder: (context, index) {
            ArticleModel? article = homeCubit.searchModel?.articles?[index];

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor2,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(article?.urlToImage ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                horizontalSpace16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article?.title ?? 'No Title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStylesManager.semiBold16,
                      ),
                      verticalSpace8,
                      Text(
                        article?.description?.trim() ?? 'No Description',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStylesManager.regular14.copyWith(
                          color: ColorsManager.textColor.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return verticalSpace16;
          },
          itemCount: homeCubit.searchModel?.articles?.length ?? 0,
        );
      },
    );
  }
}

class LoadingSearchListWidget extends StatelessWidget {
  const LoadingSearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton.leaf(
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor2,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              horizontalSpace16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStylesManager.semiBold16,
                    ),
                    verticalSpace8,
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStylesManager.regular14.copyWith(
                        color: ColorsManager.textColor.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return verticalSpace16;
        },
        itemCount: 10,
      ),
    );
  }
}

