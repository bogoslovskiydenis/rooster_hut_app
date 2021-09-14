import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rooster_hut_app/model/category.dart';
import 'package:rooster_hut_app/network/api_request.dart';
import 'package:rooster_hut_app/screens/products_list_screens.dart';
import 'package:rooster_hut_app/state/state_management.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/productList':
              return PageTransition(type: PageTransitionType.fade,
                  child: ProductListPage(),
                  settings: settings);

            // case '/productDetail':
            //   return PageTransition(type: PageTransitionType.fade,
            //       child: ProductDetailPage(dao: dao),
            //       settings: settings);
            //
            // case '/cartDetail':
            //   return PageTransition(type: PageTransitionType.fade,
            //       child: CartDetail(dao: dao),
            //       settings: settings);
            default:
              return null;
          }
        },
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

  //ignore: top_level_function_literal_block
  final _fetchCategories = FutureProvider((ref) async {
    var result = await fetchCategories();
    return result;
  });

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //var bannerApiResult = watch(_fetchBanner);
    var featureImgApiResult = watch(_fetchFeatureImg);
    var categoriesApiResult = watch(_fetchCategories);


    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: categoriesApiResult.when(
          data: (categories) => ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                          NetworkImage(categories[index].categoryImg),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        categories[index].categoryName.length <= 10
                            ? Text(categories[index].categoryName)
                            : Text(
                          categories[index].categoryName,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    // children: <Widget> [_buildList(context, categories[index])],
                    children: _buildList(context, categories[index]),
                  ),
                ),
              );
            },
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Text('$error'),
          ),
        ),
      ),
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
                              height: 500,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              initialPage: 0,
                              viewportFraction: 1)),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Colors.black,
                              ),
                              onPressed: () =>
                                  _scaffoldKey.currentState!.openDrawer()),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.navigate_before,
                                size: 45,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 45,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
              loading: () => const Center(child: CircularProgressIndicator(),),
              error: (error, stack) => Center(
                    child: Text('$error'),
                  ))
        ],
      ),
    );
  }

_buildList(BuildContext context , MyCategory category) {
  // ignore: deprecated_member_use
  List<Widget> list = [];
  category.subCategories!.forEach((element) {
    list.add(GestureDetector(child: Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        element.subCategoryName,
        style: TextStyle(fontSize: 12),
      ),
    ),
      onTap: (){
        context.read(subCategorySelected).state = element;
        Navigator.of(context).pushNamed('/productList');
      },
    ));
  });
  return list;
}
}
