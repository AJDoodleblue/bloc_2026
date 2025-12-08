import 'package:bloc_2026/features/dashboard/data/models/product.dart';

/// Products response model matching DummyJSON products list response
class ProductsResponse {
  ProductsResponse({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductsResponse.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products!.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}
