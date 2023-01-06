import "package:flutter/material.dart";
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/widgets/product_item_widget.dart';
import '../providers/home_provider.dart';
import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_icon_widget.dart';

class ProductListScreen extends StatefulWidget {
  static const routerName = "/product-list";
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).pageIndex = 0;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final pager = Provider.of<ProductProvider>(context, listen: false);

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
<<<<<<< HEAD
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<ProductProvider>(context, listen: false).Refresh();
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
=======
     backgroundColor: Colors.grey[300] ,
        body: RefreshIndicator(

          onRefresh: () async {
            Provider.of<ProductProvider>(context, listen: false).Refresh();
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
>>>>>>> a7db5a9005226029926e3fde42d117b7dcf2fcc4
          ),
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, item, index) => ProductItem(item),
          ),
        ),
      ),
    );
  }
}
