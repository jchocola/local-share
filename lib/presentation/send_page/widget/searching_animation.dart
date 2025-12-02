import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchingAnimation extends StatelessWidget {
  const SearchingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Lottie.asset('assets/Searching_Animation.json', width: size.width * 0.5, height:  size.width * 0.5,);
  }
}
