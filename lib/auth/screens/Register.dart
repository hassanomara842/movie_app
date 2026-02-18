import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../../core/colors/app_colors.dart';
import '../../core/image/app_assets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back, color: AppColors.primaryYellow),
                  Text(
                    "Register",
                    style: TextStyle(
                        color: AppColors.primaryYellow,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              const SizedBox(height: 30),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(AppImages.gamerGreen)
                  ),
                  SizedBox(width: 15),
                  CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage(AppImages.gamerRed)
                  ),
                  SizedBox(width: 15),
                  // Selected Avatar with dimensions
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(AppImages.gamerOrange)
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text("Avatar", style: TextStyle(color: AppColors.white, fontSize: 16)),
              const SizedBox(height: 20),

              _buildInput(Icons.badge_outlined, "Name"),
              const SizedBox(height: 15),
              _buildInput(Icons.email_outlined, "Email"),
              const SizedBox(height: 15),
              _buildInput(Icons.lock_outline, "Password", isPass: true),
              const SizedBox(height: 15),
              _buildInput(Icons.lock_outline, "Confirm Password", isPass: true),
              const SizedBox(height: 15),
              _buildInput(Icons.phone_outlined, "Phone Number"),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                      "Create Account",
                      style: TextStyle(color: AppColors.primaryBlack, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Footer
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have Account ? ", style: TextStyle(color: AppColors.white)),
                  Text("Login", style: TextStyle(color: AppColors.primaryYellow, fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: 85,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.darkGrey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CountryFlag.fromCountryCode('US', width: 22, height: 16),
                    ),
                    Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(color: AppColors.primaryYellow, shape: BoxShape.circle)
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CountryFlag.fromCountryCode('EG', width: 22, height: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(IconData icon, String hint, {bool isPass = false}) {
    return TextField(
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.softWhite),
        prefixIcon: Icon(icon, color: AppColors.white),
        suffixIcon: isPass ? const Icon(Icons.visibility_off_outlined, color: AppColors.white) : null,
        filled: true,
        fillColor: AppColors.darkGrey,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
        ),
      ),
    );
  }
}