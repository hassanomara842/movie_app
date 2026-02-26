import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';
import '../../home_tab/cubit/home_tab_cubit.dart';
import '../../home_tab/cubit/home_tab_states.dart';

class ContentExploreScreen extends StatelessWidget {
  const ContentExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocBuilder<HomeTabCubit, HomeTabStates>(
      builder: (context, state) {
        final cubit = context.read<HomeTabCubit>();
        final movies = cubit.allMoviesByGenre?.data?.movies;

        if (state is HomeTabGenreMoviesLoading) {
          return Center(child: Image.asset(AppAssets.popcornImage));
        }

        if (state is HomeTabGenreMoviesError) {
          return Center(
            child: Text(
              state.errorMessage,
              style: AppText.regularTextRoboto(
                  color: Colors.white, fontSize: sp(16)),
            ),
          );
        }

        if (movies == null || movies.isEmpty) {
          return Center(child: Image.asset(AppAssets.popcornImage));
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

              return Container(
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
                    color: Theme.of(context).splashColor.withOpacity(0.6),
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
              );
            },
          ),
        );
      },
    );
  }
}
