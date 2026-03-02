import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/home_layout/tabs/search_tab/cubit/search_tab_cubit.dart';
import 'package:movie_app/widgets/main_loading_widget.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/text/app_text.dart';
import '../cubit/search_tab_states.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<SearchTabCubit, SearchTabStates>(
      builder: (context, state) {
        final cubit = context.read<SearchTabCubit>();
        final movies = cubit.searchedMovies?.data?.movies;
        if (state is SearchTabInitState) {
          return Center(
              child: Column(
            spacing: h(10),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.popcornImage),
              Text("search_for_a_movie".tr(),
                  style: AppText.regularTextRoboto(
                      color: Theme.of(context).splashColor, fontSize: sp(16)))
            ],
          ));
        }
        if (state is SearchTabLoadingState) {
          return const Center(child: MainLoadingWidget());
        }

        if (state is SearchTabErrorState) {
          return Center(
            child: Text(
              state.error,
              style: AppText.regularTextRoboto(
                  color: Colors.white, fontSize: sp(16)),
            ),
          );
        }

        if (movies == null || movies.isEmpty) {
          return Center(
              child: Column(
            spacing: h(10),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.popcornImage),
              Text("no_matching_movies_found".tr(),
                  style: AppText.regularTextRoboto(
                      color: Theme.of(context).splashColor, fontSize: sp(16)))
            ],
          ));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16)),
          child: GridView.builder(
            itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: w(16),
              mainAxisSpacing: h(8),
              childAspectRatio: 191 / 279,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.movieDetailsScreen);

                },
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(w(10)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        movie.mediumCoverImage ?? '',
                      ),
                    ),
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: w(10), vertical: h(5)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).splashColor.withValues(alpha: 0.6),
                    ),
                    child: Row(
                      spacing: w(5),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie.rating?.toStringAsFixed(1) ?? '0.0',
                          style: AppText.regularTextRoboto(
                              color: Theme.of(context).primaryColor,
                              fontSize: sp(16)),
                        ),
                        Image.asset(AppAssets.star),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
