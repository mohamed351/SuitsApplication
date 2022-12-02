import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/models/category.dart';
import 'package:shopping/models/subcategory.dart';

import '../constaint/constaint.dart';
import '../models/brand.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  HomeProvider(String token);
  bool _isloading = true;
  List<Brand> _brands = [];

  List<Category> _categories = [];
  List<SubCategory> _subCateogry = [];

  List<Brand> get Brands {
    return [..._brands];
  }

  List<Category> get Categories {
    return [..._categories];
  }

  List<SubCategory> get SubCateogries {
    return [..._subCateogry];
  }

  Future<void> getInitialData() async {
    try {
      var responseCategory =
          await http.get(Uri.parse("${Constaint.baseURL}/api/Categories/top"));
      var responseBrand =
          await http.get(Uri.parse("${Constaint.baseURL}/api/Brands/top"));
      var responseSubCategory = await http
          .get(Uri.parse("${Constaint.baseURL}/api/SubCategories/top"));

      if (responseBrand.statusCode == 200 &&
          responseBrand.statusCode == 200 &&
          responseSubCategory.statusCode == 200) {
        _brands = brandFromJson(responseBrand.body);
        _categories = CategoryFromJson(responseCategory.body);
        _subCateogry = SubCategoryFromJson(responseSubCategory.body);
        _isloading = true;
        print("success");
        notifyListeners();
      }
    } catch (ex) {
      print(ex);
    }
  }
}
