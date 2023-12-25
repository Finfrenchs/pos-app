import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/core/components/buttons.dart';
import 'package:pos_app/core/extensions/build_context_ext.dart';
import 'package:pos_app/data/datasources/product_local_datasource.dart';
import 'package:pos_app/presentation/home/bloc/product/product_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../data/datasources/auth_local_datasource.dart';
import '../../auth/bloc/logout/logout_bloc.dart';
import '../../auth/pages/login_page.dart';
import 'manage_printer_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ManageMenuPage extends StatelessWidget {
  const ManageMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              children: [
                MenuButton(
                  iconPath: Assets.images.manageProduct.path,
                  label: 'Kelola Produk',
                  onPressed: () {},
                  isImage: true,
                ),
                const SpaceWidth(15.0),
                MenuButton(
                  iconPath: Assets.images.managePrinter.path,
                  label: 'Kelola Printer',
                  onPressed: () => context.push(const ManagePrinterPage()),
                  isImage: true,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  success: (_) async {
                    await ProductLocalDatasource.instance.removeAllProduct();
                    await ProductLocalDatasource.instance
                        .insertAllProduct(_.products.toList());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sync Data Success'),
                        backgroundColor: AppColors.green,
                      ),
                    );
                  },
                  error: (_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_.message),
                        backgroundColor: AppColors.red,
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.outlined(
                      onPressed: () {
                        context
                            .read<ProductBloc>()
                            .add(const ProductEvent.fetch());
                      },
                      label: 'Sync Data',
                    );
                  },
                  loading: () {
                    return const CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                    );
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: () {
                    AuthLocalDatasource().removeAuthData();

                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginPage();
                    }), (route) => false);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout Success'),
                        backgroundColor: AppColors.green,
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: AppColors.red,
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Button.filled(
                      onPressed: () {
                        context
                            .read<LogoutBloc>()
                            .add(const LogoutEvent.logout());
                      },
                      label: 'Logout',
                    );
                  },
                  loading: () {
                    return const CircularProgressIndicator(
                      backgroundColor: AppColors.primary,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
