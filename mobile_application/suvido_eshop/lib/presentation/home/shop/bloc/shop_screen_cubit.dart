import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:suvido_eshop/modules/catalog/_catalog_feature_exporter.dart';
import 'package:suvido_eshop/presentation/home/shop/bloc/shop_screen_state.dart';
import 'package:suvido_eshop/shared/_project_shared_exporter.dart';

class ShopScreenCubit extends Cubit<ShopScreenState> {
  final IProductRepository productRepository =
      GetIt.instance<IProductRepository>();

  final ICategoryRepository categoryRepository =
      GetIt.instance<ICategoryRepository>();

  ShopScreenCubit()
      : super(
          ShopScreenState.initial(),
        ) {
    initPage();
  }

  void initPage() {
    getCategories();
    getProducts();
  }

  void getCategories() async {
    emit(
      state.copyWith(
        categoryStatus: FetchStatus.loading,
      ),
    );

    var response = await categoryRepository.getCategories().run();

    response.fold(
      (l) {
        print(l);
      },
      (categoryList) {
        categoryList.insert(0, Category(identifier: 0, title: 'All', slug: ''));
        emit(
          state.copyWith(
            categoryStatus: FetchStatus.success,
            categoryList: categoryList,
          ),
        );
      },
    );
  }

  void getProducts() async {
    emit(
      state.copyWith(
        productStatus: FetchStatus.loading,
      ),
    );

    var response = await productRepository
        .getAllProducts(parameters: {'select': "title,price,images"}).run();

    response.fold(
      (l) {
        print(l);
      },
      (r) {
        emit(state.copyWith(
          productStatus: FetchStatus.success,
          productList: r,
        ));
      },
    );
  }

  void onCategorySelected(String slug, int index) {
    emit(state.copyWith(
      selectedCategory: index,
    ));
  }
}