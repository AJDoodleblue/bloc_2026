import 'package:bloc_2026/core/network/model/either.dart';
import 'package:bloc_2026/core/utils/error_logger.dart';
import 'package:bloc_2026/features/dashboard/data/models/product.dart';
import 'package:bloc_2026/features/dashboard/data/models/products_response.dart';
import 'package:bloc_2026/features/dashboard/domain/usecases/get_products_usecase.dart';
import 'package:bloc/bloc.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetProductsUseCase _getProductsUseCase;

  DashboardCubit(this._getProductsUseCase) : super(const DashboardState());

  Future<void> getProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      emit(state.copyWith(
        isLoading: true,
        page: 0,
        products: [],
        hasMore: true,
      ));
    } else {
      emit(state.copyWith(isLoading: true));
    }

    Either result = await _getProductsUseCase(
      limit: state.limit,
      skip: 0,
    );

    result.fold(
      (error) {
        ErrorLogger.log('DashboardCubit.getProducts', error.identifier);
        emit(state.copyWith(
          message: error.message,
          isFailure: true,
          isLoading: false,
        ));
      },
      (response) {
        ProductsResponse productsResponse = response as ProductsResponse;
        List<Product> productList = productsResponse.products ?? [];
        int total = productsResponse.total ?? 0;

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          products: productList,
          page: 1,
          totalProducts: total,
          hasMore: productList.length < total,
        ));
      },
    );
  }

  Future<void> loadMoreProducts() async {
    // Don't load more if already loading or no more data
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    int skip = state.products?.length ?? 0;

    Either result = await _getProductsUseCase(
      limit: state.limit,
      skip: skip,
    );

    result.fold(
      (error) {
        ErrorLogger.log('DashboardCubit.loadMoreProducts', error.identifier);
        emit(state.copyWith(
          message: error.message,
          isFailure: true,
          isLoadingMore: false,
        ));
      },
      (response) {
        ProductsResponse productsResponse = response as ProductsResponse;
        List<Product> newProducts = productsResponse.products ?? [];
        List<Product> allProducts = [...(state.products ?? []), ...newProducts];

        emit(state.copyWith(
          isLoadingMore: false,
          isSuccess: true,
          isFailure: false,
          products: allProducts,
          page: state.page + 1,
          hasMore: allProducts.length < (productsResponse.total ?? 0),
        ));
      },
    );
  }

  void clearState() {
    emit(state.copyWith(
      message: '',
      isFailure: false,
      isLoading: false,
      isSuccess: false,
    ));
  }

  void refresh() {
    getProducts(isRefresh: true);
  }
}
