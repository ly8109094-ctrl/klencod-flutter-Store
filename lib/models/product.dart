import 'package:flutter/material.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.currency,
    required this.colorValue,
    required this.description,
    this.isSellerProduct = false,
    this.sellerName = 'البائع',
  });

  final int id;
  String name;
  String category;
  double price;
  String currency;
  int colorValue;
  String description;
  bool isSellerProduct;
  String sellerName;

  Color get color => Color(colorValue);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
        'currency': currency,
        'colorValue': colorValue,
        'description': description,
        'isSellerProduct': isSellerProduct,
        'sellerName': sellerName,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        price: (json['price'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'ريال سعودي',
        colorValue: json['colorValue'] as int? ?? 0xFFB8D8D8,
        description: json['description'] as String? ?? '',
        isSellerProduct: json['isSellerProduct'] as bool? ?? false,
        sellerName: json['sellerName'] as String? ?? 'البائع',
      );
}

final List<Product> defaultProducts = [
  Product(
    id: 1,
    name: 'حقيبة يومية عملية',
    category: 'إكسسوارات',
    price: 189,
    currency: 'ريال سعودي',
    colorValue: 0xFFB8D8D8,
    description: 'حقيبة أنيقة بخامات متينة ومساحة مناسبة للاستخدام اليومي.',
  ),
  Product(
    id: 2,
    name: 'سماعات لاسلكية',
    category: 'إلكترونيات',
    price: 249,
    currency: 'ريال سعودي',
    colorValue: 0xFFD9C2FF,
    description: 'صوت واضح وتصميم مريح مع بطارية تدوم طوال اليوم.',
  ),
  Product(
    id: 3,
    name: 'كوب حراري أنيق',
    category: 'المنزل',
    price: 15000,
    currency: 'ريال يمني',
    colorValue: 0xFFFFD7A8,
    description: 'يحافظ على حرارة مشروبك بتصميم بسيط مناسب للمكتب والسفر.',
  ),
  Product(
    id: 4,
    name: 'حذاء رياضي خفيف',
    category: 'أزياء',
    price: 329,
    currency: 'ريال سعودي',
    colorValue: 0xFFAED4FF,
    description: 'راحة وخفة للحركة اليومية والتمارين الخفيفة.',
  ),
  Product(
    id: 5,
    name: 'مصباح مكتب ذكي',
    category: 'المنزل',
    price: 28000,
    currency: 'ريال يمني',
    colorValue: 0xFFFFB6C1,
    description: 'إضاءة عملية بثلاثة مستويات لتجربة عمل أكثر راحة.',
  ),
  Product(
    id: 6,
    name: 'ساعة كلاسيكية',
    category: 'إكسسوارات',
    price: 299,
    currency: 'ريال سعودي',
    colorValue: 0xFFD2E5B5,
    description: 'تصميم كلاسيكي يضيف لمسة راقية إلى إطلالتك.',
  ),
];
