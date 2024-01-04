import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos_app/core/extensions/int_ext.dart';
import 'package:pos_app/data/models/response/product_response_model.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/variables.dart';
import '../../home/models/product_model.dart';

import 'change_price_bottom_sheet.dart';

class MenuProductItem extends StatelessWidget {
  final Product data;
  const MenuProductItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: AppColors.purpleLight),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            child: CachedNetworkImage(
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              imageUrl: "${Variables.imageBaseUrl}${data.image}",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => SvgPicture.asset(
                Assets.icons.allCategories.path,
                color: AppColors.primary,
              ),
            ),
          ),
          const SpaceWidth(22.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SpaceHeight(5.0),
                Text(
                  data.category,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SpaceHeight(10.0),
                Row(
                  children: [
                    Flexible(
                      child: Button.outlined(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(16),
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SpaceHeight(10),
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        child: CachedNetworkImage(
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${Variables.imageBaseUrl}${data.image}",
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                            Assets.icons.allCategories.path,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                      Text(
                                        data.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                      Text(
                                        data.price.currencyFormatRp,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                      Text(
                                        data.stock.toString(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SpaceHeight(10.0),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        label: 'Detail',
                        fontSize: 8.0,
                        fontWeight: FontWeight.w800,
                        height: 31,
                      ),
                    ),
                    const SpaceWidth(6.0),
                    Flexible(
                      child: Button.outlined(
                        onPressed: () {
                          // context.push(EditProductPage(data: data));
                        },
                        label: 'Ubah Produk',
                        fontWeight: FontWeight.w800,
                        fontSize: 8.0,
                        height: 31,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
