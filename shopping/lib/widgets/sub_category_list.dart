import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/brand.dart';
import 'package:shopping/providers/home_provider.dart';

class SubCateogryListWidget extends StatelessWidget {
  const SubCateogryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
              child: Column(
            children: [
              Image.network(
                provider.SubCateogries[index].imageUrl.toString(),
                width: 100,
              ),
              Text(provider.SubCateogries[index].englishName.toString())
            ],
          ));
        },
        itemCount: provider.SubCateogries.length,
      ),
    );
  }
}