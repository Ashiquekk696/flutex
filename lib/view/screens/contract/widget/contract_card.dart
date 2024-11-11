import 'package:flutex_admin/core/helper/date_converter.dart';
import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/core/utils/color_resources.dart';
import 'package:flutex_admin/core/utils/dimensions.dart';
import 'package:flutex_admin/core/utils/local_strings.dart';
import 'package:flutex_admin/core/utils/style.dart';
import 'package:flutex_admin/data/model/contract/contract_model.dart';
import 'package:flutex_admin/view/components/divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ContractCard extends StatelessWidget {
  const ContractCard({
    super.key,
    required this.index,
    required this.model,
  });
  
  final int index;
  final ContractsModel model;

  @override
  Widget build(BuildContext context) {
    final contractData = model.data;
    final contractItem = (contractData != null && index < contractData.length)
        ? contractData[index]
        : null;

    return GestureDetector(
      onTap: () => Get.toNamed(
        RouteHelper.contractDetailsScreen,
        arguments: contractItem?.id ?? '',
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(
                left: BorderSide(
                  width: 5.0,
                  color: Colors.lightBlue.shade600,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contractItem?.subject ?? '',
                        style: regularDefault,
                      ),
                      Text(
                        contractItem?.contractValue ?? '',
                        style: regularDefault,
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        contractItem?.description ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: lightSmall.copyWith(
                          color: ColorResources.blueGreyColor,
                        ),
                      ),
                      Text(
                        contractItem?.signed == '0'
                            ? LocalStrings.notSigned.tr
                            : LocalStrings.signed.tr,
                        style: lightSmall.copyWith(
                          color: ColorResources.contractStatusColor(
                            contractItem?.signed ?? '0',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CustomDivider(space: Dimensions.space10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextIcon(
                        text: contractItem?.company ?? '',
                        prefix: const Icon(
                          Icons.account_box_rounded,
                          color: ColorResources.primaryColor,
                          size: 14,
                        ),
                        edgeInsets: EdgeInsets.zero,
                        textStyle: lightSmall.copyWith(
                          color: ColorResources.blueGreyColor,
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.space12,
                      ),
                      TextIcon(
                        text: DateConverter.formatValidityDate(
                          "${contractItem?.dateAdded ?? ''} 00:00:00",
                        ),
                        prefix: const Icon(
                          Icons.calendar_month,
                          color: ColorResources.primaryColor,
                          size: 14,
                        ),
                        edgeInsets: EdgeInsets.zero,
                        textStyle: lightSmall.copyWith(
                          color: ColorResources.blueGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
