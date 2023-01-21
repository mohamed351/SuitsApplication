import "package:flutter/material.dart";
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/providers/product_brand_provider.dart';
import 'package:shopping/widgets/product_item_widget.dart';
import '../constaint/constaint.dart';
import '../providers/sub_category_provider.dart';

class ProductSubCategoryScreen extends StatefulWidget {
  static const routerName = "/subcategoy-screen";
  const ProductSubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductSubCategoryScreen> createState() =>
      _ProductSubCategoryListScreenState();
}

class _ProductSubCategoryListScreenState
    extends State<ProductSubCategoryScreen> {
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    Provider.of<ProductBrandProvider>(context, listen: false).pageIndex = 0;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final pager = Provider.of<SubCategoryProvider>(context, listen: false);

      final newItems = await pager.initailLoad(10);
      final isLastPage = newItems.length == 0;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Constaint.primaryColor,
          title: Text(Provider.of<SubCategoryProvider>(context)
              .subCategoryName
              .toString())),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<SubCategoryProvider>(context, listen: false).Refresh();
          _pagingController.refresh();
        },
        child: PagedGridView<int, Product>(
          padding: EdgeInsets.only(top: 10, left: 5, right: 5),
          showNewPageProgressIndicatorAsGridChild: false,
          showNewPageErrorIndicatorAsGridChild: false,
          showNoMoreItemsIndicatorAsGridChild: false,
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 150 / 200,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, item, index) => ProductItem(item),
          ),
        ),
      ),
    );
  }
}