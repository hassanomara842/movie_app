import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/home_layout/tabs/home_tab/widget/movie_card.dart';
import 'package:movie_app/home_layout/tabs/home_tab/widget/movie_cover.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/size_config.dart';
import '../../../core/text/app_text.dart';
import '../../../widgets/main_loading_widget.dart';
import 'cubit/home_tab_cubit.dart';
import 'cubit/home_tab_states.dart';
import 'package:movie_app/di/injection.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => getIt<HomeTabCubit>()
        ..getMovies()
        ..getMoviesByGenre(),
      child: Scaffold(
        body: BlocBuilder<HomeTabCubit, HomeTabStates>(
          builder: (context, state) {
            final cubit = context.read<HomeTabCubit>();
            return Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppAssets.homeTabBG,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: h(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: h(30)),
                      Image.asset(AppAssets.availableNow, fit: BoxFit.contain),
                      
                      _buildUpperSection(state, cubit),

                      Image.asset(AppAssets.watchNow, fit: BoxFit.contain),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(cubit.currentGenre?.tr() ?? "Action".tr(),
                                style: AppText.regularTextRoboto(
                                    color: AppColors.white, fontSize: 20.sp)),
                            TextButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("see_more".tr(),
                                        style: AppText.regularTextRoboto(
                                            color: AppColors.primaryYellow,
                                            fontSize: 16.sp)),
                                    SizedBox(width: w(5)),
                                    const Icon(
                                      size: 16,
                                      Icons.arrow_forward_outlined,
                                      color: AppColors.primaryYellow,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _buildLowerSection(state, cubit),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUpperSection(HomeTabStates state, HomeTabCubit cubit) {
    final movies = cubit.allMovies?.data?.movies;

    // Prioritize showing movies if they exist (even while loading)
    if (movies != null && movies.isNotEmpty) {
      return CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) {
          return MovieCover(
            coverImageUrl: movies[index].mediumCoverImage ?? '',
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          height: h(350),
          viewportFraction: 0.60,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: true,
        ),
      );
    }

    if (state is HomeTabAllMoviesLoading) {
      return SizedBox(
        height: h(350),
        child: const Center(child: MainLoadingWidget()),
      );
    } else if (state is HomeTabAllMoviesError) {
      return _buildErrorState(state.errorMessage, () => cubit.getMovies());
    }
    
    return SizedBox(height: h(350));
  }

  Widget _buildLowerSection(HomeTabStates state, HomeTabCubit cubit) {
    final movies = cubit.allMoviesByGenre?.data?.movies;

    if (movies != null && movies.isNotEmpty) {
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: w(16)),
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) => MovieCard(
          movie: movies[index],
        ),
        separatorBuilder: (context, index) => SizedBox(width: w(16)),
      );
    }

    if (state is HomeTabGenreMoviesLoading) {
      return const Center(child: MainLoadingWidget());
    } else if (state is HomeTabGenreMoviesError) {
      return _buildErrorState(
          state.errorMessage, () => cubit.getMoviesByGenre(cubit.currentGenre));
    }

    return const SizedBox();
  }

  Widget _buildErrorState(String message, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.popcornImage, width: 100.w),
          Text(
            message,
            textAlign: TextAlign.center,
            style:
                AppText.regularTextRoboto(color: Colors.white, fontSize: 16.sp),
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text("Try Again",
                style: TextStyle(color: AppColors.primaryYellow)),
          )
        ],
      ),
    );
  }
}
