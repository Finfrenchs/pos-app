import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/core/constants/colors.dart';
import 'package:pos_app/core/extensions/build_context_ext.dart';
import 'package:pos_app/presentation/home/bloc/product/product_bloc.dart';

import '../../../core/components/spaces.dart';
import '../widgets/menu_product_item.dart';
import 'add_product_page.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  // final List<ProductModel> products = [
  //   ProductModel(
  //     image: Assets.images.f1.path,
  //     name: 'Vanila Late Vanila itu',
  //     category: ProductCategory.drink,
  //     price: 200000,
  //     stock: 10,
  //   ),
  //   ProductModel(
  //     image: Assets.images.f2.path,
  //     name: 'V60',
  //     category: ProductCategory.drink,
  //     price: 1200000,
  //     stock: 10,
  //   ),
  //   ProductModel(
  //     image: Assets.images.f3.path,
  //     name: 'Americano',
  //     category: ProductCategory.drink,
  //     price: 2100000,
  //     stock: 10,
  //   ),
  //   ProductModel(
  //     image: Assets.images.f4.path,
  //     name: 'Coklat',
  //     category: ProductCategory.food,
  //     price: 200000,
  //     stock: 10,
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const Text(
            'List Produk',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(20.0),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
                success: (products) {
                  return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 55),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(20.0),
                      itemBuilder: (context, index) {
                        return MenuProductItem(
                          data: products[index],
                        );
                      });
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          context.push(const AddProductPage());
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}
