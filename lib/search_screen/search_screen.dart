import 'package:flutter/material.dart';
import 'package:movie_app/core/image/app_assets.dart';

import '../core/colors/app_colors.dart';
import '../widgets/custom_text_form_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              CustomTextFormField(
                cursorColor: AppColors.primaryYellow,
                style: TextStyle(color: AppColors.white),
                controller: searchController,

                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).focusColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(AppAssets.popcornImage,
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}