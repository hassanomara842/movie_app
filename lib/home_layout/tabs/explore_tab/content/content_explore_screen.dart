import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/widgets/main_loading_widget.dart';
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
        final movies = cubit.genreMoviesList[0]?.data?.movies;

        if (state is HomeTabGenreMoviesLoading &&
            state.index == 0 &&
            (movies == null || movies.isEmpty)) {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).cardColor));
        }

        if (state is HomeTabGenreMoviesError &&
            state.index == 0 &&
            (movies == null || movies.isEmpty)) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.popcornImage, width: w(150)),
                SizedBox(height: h(20)),
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                  style: AppText.regularTextRoboto(
                      color: Colors.white, fontSize: sp(16)),
                ),
                TextButton(
                  onPressed: () => cubit.getMoviesByGenre(0, cubit.genreNames[0]),
                  child: Text("Try Again",
                      style: TextStyle(color: Theme.of(context).cardColor)),
                )
              ],
            ),
          );
        }

        if (movies == null || movies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.popcornImage, width: w(150)),
                SizedBox(height: h(20)),
                Text(
                  "No movies found",
                  style: AppText.regularTextRoboto(
                      color: Colors.white, fontSize: sp(16)),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: w(16)),
          child: GridView.builder(
            itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: w(16),
              mainAxisSpacing: h(16),
              childAspectRatio: 191 / 279,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];

              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  cubit.addToHistory(movie);
                  Navigator.pushNamed(context, AppRoutes.movieDetailsScreen,
                      arguments: movie.id);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: movie.mediumCoverImage ?? '',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(w(10)),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: imageProvider,
                        ),
                      ),
                      child: _buildRatingBadge(context, movie.rating),
                    ),
                    placeholder: (context, url) => Container(
                      color: Theme.of(context).canvasColor,
                      child: const Center(child: MainLoadingWidget()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Theme.of(context).canvasColor,
                      child: const Icon(Icons.error, color: Colors.white),
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

  Widget _buildRatingBadge(BuildContext context, double? rating) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(5)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).splashColor.withValues(alpha: 0.6),
      ),
      child: Row(
        spacing: w(5),
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating?.toStringAsFixed(1) ?? '0.0',
            style: AppText.regularTextRoboto(
                color: Theme.of(context).primaryColor, fontSize: sp(16)),
          ),
          Image.asset(AppAssets.star),
        ],
      ),
    );
  }
}
