import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/text_styles.dart';
import 'package:news_app/core/util/constants/spacing.dart';
import 'package:news_app/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app/features/home/presentation/logic/home_states.dart';

List<String> categories = [
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'Technology',
];

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      buildWhen: (previous, current) {
        return current is ChangeSelectedIndexState;
      },
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              horizontalSpace16,
              ...categories.map(
                (category) {
                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          homeCubit.selectedIndex = categories.indexOf(category);
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: homeCubit.selectedIndex == categories.indexOf(category)
                                ? ColorsManager.primaryColor2
                                : ColorsManager.textColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Text(
                            category,
                            style: TextStylesManager.semiBold16.copyWith(
                              color: homeCubit.selectedIndex == categories.indexOf(category) ? ColorsManager.whiteColor : null,
                            ),
                          ),
                        ),
                      ),
                      if (categories.indexOf(category) != categories.length - 1) horizontalSpace8,
                    ],
                  );
                },
              ),
              horizontalSpace16,
            ],
          ),
        );
      },
    );
  }
}
