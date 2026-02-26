import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../cubit/profile_cubit.dart';
import '../../di/injection.dart';
import '../tabs/explore_tab/explore_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/profile_tab/profile/profile_screen.dart';
import '../tabs/search_tab/search_tab.dart';
import 'home_layout_states.dart';

@injectable
class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInitState());
  int selectedIndex = 0;
  final List<Widget> pages = [
    const HomeTab(),
    const SearchTab(),
    const ExploreTab(),
    BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getUserProfile(),
      child: const ProfileScreen(),
    ),
  ];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(HomeLayoutChangeIndexState(index: index));
  }
}
