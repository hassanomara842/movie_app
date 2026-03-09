import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/di/injection.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/cast_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/download_section.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/genres_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/icon_text_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/screen_shots_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/similer_widget.dart';
import 'package:movie_app/home_layout/tabs/movie_details/widgets/video_play_widget.dart';
import 'package:movie_app/model/movie_details_response/movie_details_response.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/main_loading_widget.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/size_config.dart';
import 'cubit/movie_details_cubit.dart';
import 'cubit/movie_details_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => getIt<MovieDetailsCubit>()
        ..getMovieDetails(movieId: movieId)
        ..getMovieSuggestions(movieId: movieId),
      child: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
          builder: (context, state) {
        final cubit = context.read<MovieDetailsCubit>();
        final Movie? movie = cubit.movieDetails?.data?.movie;

        if (state is MovieDetailsLoadingState) {
          return const Scaffold(
            body: Center(child: MainLoadingWidget()),
          );
        }

        if (state is MovieDetailsErrorState) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.popcornImage, width: 150.w),
                  SizedBox(height: h(20)),
                  Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: AppText.regularTextRoboto(
                        color: Colors.white, fontSize: sp(16)),
                  ),
                  TextButton(
                    onPressed: () => cubit.getMovieDetails(movieId: movieId),
                    child: const Text("Try Again",
                        style: TextStyle(color: AppColors.primaryYellow)),
                  )
                ],
              ),
            ),
          );
        }

        if (movie == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text("No Data Found")),
          );
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              spacing: h(16),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                VideoPlayWidget(movie: movie),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w(10),
                  ),
                  child: Column(
                    spacing: h(10),
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                          buttonTitle: "watch".tr(),
                          onPressed: () {
                            if (movie.url != null) {
                              Navigator.pushNamed(
                                context,
                                '/watchMovieScreen',
                                arguments: {
                                  'url': movie.url,
                                  'movieTitle': movie.title ?? 'Watch Movie',
                                },
                              );
                            }
                          },
                          textColor: AppColors.white,
                          backgroundColor: AppColors.errorRed),
                      Row(
                        spacing: w(10),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconTextWidget(
                              text: movie.likeCount?.toString() ?? "0",
                              image: AppAssets.favouriteIcon,
                            ),
                          ),
                          Expanded(
                              child: IconTextWidget(
                                  text: "${movie.runtime ?? 0} ${"min".tr()}",
                                  image: AppAssets.timeIcon)),
                          Expanded(
                              child: IconTextWidget(
                                  text: movie.rating?.toString() ?? "0.0",
                                  image: AppAssets.star)),
                        ],
                      ),
                      title("screen_shots", context),
                      ScreenShotsListWidget(movie: movie),
                      title("similar", context),
                      SimilerWidget(
                          movies: cubit.movieSuggestions?.data?.movies),
                      title("summary", context),
                      Text(
                        movie.descriptionFull ?? "",
                        style: AppText.regularTextRoboto(
                            color: Theme.of(context).splashColor,
                            fontSize: sp(16)),
                      ),
                      title("cast", context),
                      CastWidget(cast: movie.cast),
                      title("download", context),
                      DownloadSection(movie: movie),
                      title("genres", context),
                      GenresListWidget(genres: movie.genres ?? [])
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Text title(String title, BuildContext context) {
    return Text(title.tr(),
        style: AppText.boldTextRoboto(
            color: Theme.of(context).splashColor, fontSize: sp(25)));
  }
}
