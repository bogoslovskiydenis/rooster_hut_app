import 'dart:convert';


Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.productId,
    required this.productName,
    required this.productShortDescription,
    required this.productDescription,
    this.productOldPrice,
    this.productNewPrice,
    this.productIsSale,
    this.productSaleText,
    required this.productSubText,
    this.productOrderNumber,
    this.productCreateDate,
    required this.productCode,
    this.subCategoryId,
    this.subCategory,
    this.productColours,
    this.productFabrics,
    this.productImages,
    this.productJacketModels,
    this.productPatterns,

  });

  int productId;
  String productName;
  String productShortDescription;
  String productDescription;
  double? productOldPrice;
  double? productNewPrice;
  bool? productIsSale;
  dynamic? productSaleText;
  String productSubText;
  int? productOrderNumber;
  DateTime? productCreateDate;
  String productCode;
  int? subCategoryId;
  dynamic? subCategory;
  List<dynamic>? productColours;
  List<dynamic>? productFabrics;
  List<ProductImage>? productImages;
  List<dynamic>? productJacketModels;
  List<dynamic>? productPatterns;


  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"]as int,
    productName: json["productName"],
    productShortDescription: json["productShortDescription"],
    productDescription: json["productDescription"],
    productOldPrice: json["productOldPrice"]as double,
    productNewPrice: json["productNewPrice"]as double,
    productIsSale: json["productIsSale"],
    productSaleText: json["productSaleText"],
    productSubText: json["productSubText"],
    productOrderNumber: json["productOrderNumber"]as int,
    productCreateDate: DateTime.parse(json["productCreateDate"]),
    productCode: json["productCode"],
    subCategoryId: json["subCategoryId"]as int,
    //

    productColours: List<dynamic>.from(json["productColours"].map((x) => x)),
    productFabrics: List<dynamic>.from(json["productFabrics"].map((x) => x)),
    productImages: List<ProductImage>.from(json["productImages"].map((x) => ProductImage.fromJson(x))),
    productJacketModels: List<dynamic>.from(json["productJacketModels"].map((x) => x)),
    productPatterns: List<dynamic>.from(json["productPatterns"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "productShortDescription": productShortDescription,
    "productDescription": productDescription,
    "productOldPrice": productOldPrice,
    "productNewPrice": productNewPrice,
    "productIsSale": productIsSale,
    "productSaleText": productSaleText,
    "productSubText": productSubText,
    "productOrderNumber": productOrderNumber,
    "productCreateDate": productCreateDate!.toIso8601String(),
    "productCode": productCode,
    "subCategoryId": subCategoryId,
    "subCategory": subCategory,
    "productColours": List<dynamic>.from(productColours!.map((x) => x)),
    "productFabrics": List<dynamic>.from(productFabrics!.map((x) => x)),
    "productImages": List<dynamic>.from(productImages!.map((x) => x.toJson())),
    "productJacketModels": List<dynamic>.from(productJacketModels!.map((x) => x)),
    "productPatterns": List<dynamic>.from(productPatterns!.map((x) => x)),

  };
}

class ProductImage {
  ProductImage({
    required this.imgId,
    required this.imgUrl,
    required this.productId,
  });

  int imgId;
  String imgUrl;
  int productId;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
    imgId: json["imgId"],
    imgUrl: json["imgUrl"],
    productId: json["productId"],
  );

  Map<String, dynamic> toJson() => {
    "imgId": imgId,
    "imgUrl": imgUrl,
    "productId": productId,
  };
}




