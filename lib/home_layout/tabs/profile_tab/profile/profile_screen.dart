import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/cubit/wishlist_cubit.dart';
import 'package:movie_app/cubit/wishlist_state.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/model/movie_details_response/movie_details_response.dart';
import 'package:movie_app/home_layout/tabs/movie_details/movie_details_screen.dart';

import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  const ProfileHeader(),
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColors.primaryYellow,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.primaryYellow,
                    unselectedLabelColor: Theme.of(context).splashColor,
                    tabs: [
                      Tab(
                        icon: const Icon(Icons.list),
                        text: "wish_list".tr(),
                      ),
                      Tab(
                        icon: const Icon(Icons.folder),
                        text: "history".tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildWishlistTab(context),
                  _buildEmptyState(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistTab(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        if (state is WishlistLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WishlistError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                state.message,
                style: AppText.mediumText(
                  color: Theme.of(context).splashColor,
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final movies = (state is WishlistLoaded) ? state.movies : <Movie>[];
        if (movies.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          itemBuilder: (context, index) {
            final m = movies[index];
            return _WishlistMovieTile(movie: m);
          },
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemCount: movies.length,
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.popcornImage,
            width: 150.w,
          ),
        ],
      ),
    );
  }
}

class _WishlistMovieTile extends StatelessWidget {
  final Movie movie;

  const _WishlistMovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        final id = movie.id;
        if (id == null) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movieId: id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Theme.of(context).disabledColor),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: movie.mediumCoverImage == null
                  ? Image.asset(
                      AppAssets.discoverMovies,
                      width: 60.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      movie.mediumCoverImage!,
                      width: 60.w,
                      height: 80.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        AppAssets.discoverMovies,
                        width: 60.w,
                        height: 80.h,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.semiBoldText(
                      color: Theme.of(context).splashColor,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    [
                      if (movie.year != null) movie.year.toString(),
                      if (movie.rating != null) '⭐ ${movie.rating!.toStringAsFixed(1)}',
                    ].join('  •  '),
                    style: AppText.regularText(
                      color: AppColors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
