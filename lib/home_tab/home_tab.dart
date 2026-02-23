import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/home_tab/widget/movie_card.dart';
import 'package:movie_app/home_tab/widget/movie_cover.dart';
import '../core/responsive/responsive.dart';
import '../core/responsive/size_config.dart';
import '../core/text/app_text.dart';
import '../widgets/main_loading_widget.dart';
import 'cubit/home_tab_cubit.dart';
import 'cubit/home_tab_states.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return BlocProvider(
      create: (context) => HomeTabCubit()
        ..getMovies()
        ..getMoviesByGenre(),
      child: Scaffold(
        body: BlocBuilder<HomeTabCubit, HomeTabStates>(
          builder: (context, state) {
            final cubit = BlocProvider.of<HomeTabCubit>(context);
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
                      if (state is HomeTabAllMoviesLoading)
                        SizedBox(
                          height: h(350),
                          child: const Center(child: MainLoadingWidget()),
                        )
                      else if (state is HomeTabAllMoviesError)
                        SizedBox(
                          height: h(350),
                          child: Center(
                            child: Text(
                              state.errorMessage,
                              style: AppText.regularTextRoboto(
                                  color: Colors.white, fontSize: 16.sp),
                            ),
                          ),
                        )
                      else if (cubit.allMovies?.data?.movies != null)
                        CarouselSlider.builder(
                          itemCount: cubit.allMovies!.data!.movies!.length,
                          itemBuilder: (context, index, realIndex) {
                            return MovieCover(
                              coverImageUrl: cubit.allMovies!.data!
                                      .movies![index].mediumCoverImage ??
                                  '',
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
                        ),
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
                                  spacing: w(5),
                                  children: [
                                    Text("see_more".tr(),
                                        style: AppText.regularTextRoboto(
                                            color: AppColors.primaryYellow,
                                            fontSize: 16.sp)),
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
                        child: state is HomeTabGenreMoviesLoading
                            ? const Center(child: MainLoadingWidget())
                            : state is HomeTabGenreMoviesError
                                ? Center(
                                    child: Text(
                                      state.errorMessage,
                                      style: AppText.regularTextRoboto(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                  )
                                : cubit.allMoviesByGenre?.data?.movies != null
                                    ? ListView.separated(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: w(16)),
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: cubit.allMoviesByGenre!.data!
                                            .movies!.length,
                                        itemBuilder: (context, index) =>
                                            MovieCard(
                                          movie: cubit.allMoviesByGenre!.data!
                                              .movies![index],
                                        ),
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                SizedBox(
                                          width: w(16),
                                        ),
                                      )
                                    : const SizedBox(),
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
}
