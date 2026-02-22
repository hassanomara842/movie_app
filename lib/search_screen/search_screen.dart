import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/text/app_text.dart';

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
          child:
          CustomTextFormField(
            cursorColor: AppColors.primaryYellow,
            style: TextStyle(color: AppColors.white),
            controller: searchController,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: AppColors.white,fontSize: 16),
              hintTextDirection: TextDirection.ltr,
              suffixIcon: const Icon(Icons.search,color: Colors.white,size: 28,),
              filled: true,
              fillColor: AppColors.darkGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),

        ),
      ),
    );
  }
}