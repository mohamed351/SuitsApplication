import "package:flutter/material.dart";
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/product_list.dart';
import 'package:shopping/providers/product_brand_provider.dart';
import 'package:shopping/widgets/product_item_widget.dart';
import '../constaint/constaint.dart';

class ProductBrandListScreen extends StatefulWidget {
  static const routerName = "/product-brand-list";
  const ProductBrandListScreen({Key? key}) : super(key: key);

  @override
  State<ProductBrandListScreen> createState() => _ProductBrandListScreenState();
}

class _ProductBrandListScreenState extends State<ProductBrandListScreen> {
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
      final pager = Provider.of<ProductBrandProvider>(context, listen: false);

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
          title: Text(Provider.of<ProductBrandProvider>(context, listen: true)
              .brandName
              .toString())),
      body: Container(
        height: 700,
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: Constaint.thirdColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            Provider.of<ProductBrandProvider>(context, listen: false).Refresh();
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
      ),
    );
  }
}
