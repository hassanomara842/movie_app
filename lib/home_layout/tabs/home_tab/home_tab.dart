import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/home_layout/cubit/home_layout_cubit.dart';
import 'package:movie_app/home_layout/tabs/home_tab/widget/movie_card.dart';
import 'package:movie_app/home_layout/tabs/home_tab/widget/movie_cover.dart';
import 'package:movie_app/widgets/App_Shimmer/app_shimmer.dart';
import 'package:movie_app/widgets/App_Shimmer/movie_card_shimmer.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/size_config.dart';
import '../../../core/text/app_text.dart';
import 'cubit/home_tab_cubit.dart';
import 'cubit/home_tab_states.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final cubit = context.read<HomeTabCubit>();

    return Scaffold(
      body: BlocBuilder<HomeTabCubit, HomeTabStates>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppAssets.homeTabBG,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover),
              Padding(
                padding: EdgeInsets.symmetric(vertical: h(12)),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: h(10),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: h(30)),
                      Image.asset(AppAssets.availableNow,
                          fit: BoxFit.contain),
                      _buildUpperSection(state, cubit),
                      Image.asset(AppAssets.watchNow, fit: BoxFit.contain),
                      _buildGenreSectionWithMovies(state, cubit, 1),
                      _buildGenreSectionWithMovies(state, cubit, 2),
                      _buildGenreSectionWithMovies(state, cubit, 3),
                      SizedBox(height: h(100)),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildGenreSectionWithMovies(
      HomeTabStates state, HomeTabCubit cubit, int index) {
    return Column(
      children: [
        _buildGenreHeader(cubit, index),
        SizedBox(
          height: h(250),
          child: _buildLowerSection(state, cubit, index),
        ),
      ],
    );
  }

  Widget _buildGenreHeader(HomeTabCubit cubit, int index) {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: w(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cubit.genreNames[index]?.tr() ?? "Loading...".tr(),
                style: AppText.regularTextRoboto(
                    color: AppColors.white, fontSize: 20.sp)),
            TextButton(
                onPressed: () {
                  final genre = cubit.genreNames[index];
                  if (genre != null) {
                    cubit.getMoviesByGenre(0, genre);
                    context.read<HomeLayoutCubit>().changeIndex(2);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("see_more".tr(),
                        style: AppText.regularTextRoboto(
                            color: AppColors.primaryYellow, fontSize: 16.sp)),
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
      );
    });
  }

  Widget _buildUpperSection(HomeTabStates state, HomeTabCubit cubit) {
    final movies = cubit.allMovies?.data?.movies;

    if (movies != null && movies.isNotEmpty) {
      return CarouselSlider.builder(
        itemCount: movies.length,
        itemBuilder: (context, index, realIndex) {
          return MovieCover(
            coverImageUrl: movies[index].mediumCoverImage ?? '',
            movieId: movies[index].id!,
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
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppShimmer.rectangular(height: h(350), width: w(210)),
          ),
        ),
      );
    } else if (state is HomeTabAllMoviesError) {
      return _buildErrorState(state.errorMessage, () => cubit.getMovies());
    }

    return SizedBox(height: h(350));
  }

  Widget _buildLowerSection(
      HomeTabStates state, HomeTabCubit cubit, int index) {
    final movies = cubit.genreMoviesList[index]?.data?.movies;

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

    bool isLoading =
        (state is HomeTabGenreMoviesLoading && state.index == index);

    if (isLoading && (movies == null || movies.isEmpty)) {
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: w(16)),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => const MovieCardShimmer(),
        separatorBuilder: (context, index) => SizedBox(width: w(16)),
      );
    } else if (state is HomeTabGenreMoviesError &&
        state.index == index &&
        (movies == null || movies.isEmpty)) {
      return _buildErrorState(state.errorMessage,
          () => cubit.getMoviesByGenre(index, cubit.genreNames[index]));
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
