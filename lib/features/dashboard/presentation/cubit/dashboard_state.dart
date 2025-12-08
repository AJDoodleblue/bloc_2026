import 'package:equatable/equatable.dart';
import 'package:bloc_2026/features/dashboard/data/models/product.dart';

class DashboardState extends Equatable {
  final int page;
  final int totalProducts;
  final int limit;
  final String message;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFailure;
  final bool isSuccess;
  final bool hasMore;
  final List<Product>? products;

  const DashboardState({
    this.page = 0,
    this.totalProducts = 0,
    this.limit = 10,
    this.message = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFailure = false,
    this.isSuccess = false,
    this.hasMore = true,
    this.products,
  });

  DashboardState copyWith({
    int? page,
    int? totalProducts,
    int? limit,
    String? message,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFailure,
    bool? isSuccess,
    bool? hasMore,
    List<Product>? products,
  }) {
    return DashboardState(
      page: page ?? this.page,
      totalProducts: totalProducts ?? this.totalProducts,
      limit: limit ?? this.limit,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFailure: isFailure ?? this.isFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      hasMore: hasMore ?? this.hasMore,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        page,
        totalProducts,
        limit,
        message,
        isLoading,
        isLoadingMore,
        isFailure,
        isSuccess,
        hasMore,
        products,
      ];
}
