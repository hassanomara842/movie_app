import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import '../core/responsive/size_config.dart';
import 'movie_card.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  int selectedIndex = 0;

  final List<String> movies = [
    AppAssets.blackwidow,
    AppAssets.joker,
    AppAssets.avengers,
    AppAssets.hobbsshaw,
    AppAssets.civilwar,
    AppAssets.dok,
  ];

  final List<String> categories = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.055,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryChip(
                      title: categories[index],
                      selected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Expanded(
                child: GridView.builder(
                  itemCount: movies.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenHeight * 0.01,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    return MovieCard(
                      imagePath: movies[index],
                      rating: 7.7,
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: screenWidth * 0.02),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.012,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primaryYellow
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryYellow,
            width: 2.5,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color:
            selected ? Colors.black : AppColors.primaryYellow,
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}