


import 'package:flutter_riverpod/all.dart';
import 'package:rooster_hut_app/model/category.dart';
import 'package:rooster_hut_app/model/product.dart';

final subCategorySelected = StateProvider((ref)=> SubCategory(subCategoryName: '', subCategoryId: 0));
final productSelected = StateProvider((ref)=> Product(productName: '', productShortDescription: '',
    productDescription: '', productSubText: '', productCode: '', productId: 0));