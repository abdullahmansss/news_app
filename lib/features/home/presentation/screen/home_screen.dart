import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/theme/colors.dart';
import 'package:news_app/core/theme/text_styles.dart';
import 'package:news_app/core/util/constants/spacing.dart';
import 'package:news_app/features/home/data/article_model.dart';
import 'package:news_app/features/home/presentation/logic/home_cubit.dart';
import 'package:news_app/features/home/presentation/logic/home_states.dart';
import 'package:news_app/features/home/presentation/widgets/categories_list.dart';
import 'package:news_app/features/home/presentation/widgets/search_list_widget.dart';

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

  Timer? debounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Search Your Daily News',
                    style: TextStylesManager.bold20,
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: ColorsManager.primaryColor2,
                    backgroundImage: const NetworkImage('https://avatars.githubusercontent.com/u/34492145?v=4'),
                  ),
                ],
              ),
            ),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TextFormField(
                    controller: homeCubit.searchController,
                    style: TextStylesManager.medium16,
                    onChanged: (String text) {
                      if (text.characters.length > 3) {
                        if (debounce?.isActive ?? false) debounce!.cancel();

                        debounce = Timer(const Duration(seconds: 2), () {
                          // Call your API or search logic here
                          homeCubit.searchNews(
                            text: text,
                          );
                          // Example: fetchResults(query);
                        });
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ColorsManager.whiteColor,
                      hintText: 'Search for news',
                      hintStyle: TextStylesManager.regular14.copyWith(
                        color: ColorsManager.textColor.withValues(alpha: 0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorsManager.textColor.withValues(alpha: 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: homeCubit.searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                homeCubit.searchController.clear();
                                homeCubit.selectedIndex = homeCubit.selectedIndex;
                              },
                              icon: const Icon(Icons.clear),
                              color: ColorsManager.textColor.withValues(alpha: 0.5),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
            verticalSpace24,
            CategoriesList(),
            verticalSpace24,
            Expanded(
              child: SearchListWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
