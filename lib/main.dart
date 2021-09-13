import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rooster_hut_app/network/api_request.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  //ignore: top_level_function_literal_block
final _fetchBanner = FutureProvider((ref) async {
    var result = await fetchBanner();
    return result;
  });

  //ignore: top_level_function_literal_block
  final _fetchFeatureImg = FutureProvider((ref) async {
    var result = await fetchFeatureImages();
    return result;
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //var bannerApiResult = watch(_fetchBanner);
    var featureImgApiResult = watch(_fetchFeatureImg);

    return Scaffold(
      body: Column(
        children: [
          featureImgApiResult.when(
              data: (featureImages) => Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                          items: featureImages
                              .map((e) => Builder(
                                    builder: (context) => Image(
                                      image: NetworkImage(e.featureImgUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              initialPage: 0,
                              viewportFraction: 1))
                    ],
                  ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Center(
                    child: Text('$error'),
                  ))
        ],
      ),
    );
  }
}
