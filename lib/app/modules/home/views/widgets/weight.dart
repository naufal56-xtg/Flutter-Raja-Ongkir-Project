import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class Weight extends GetView<HomeController> {
  const Weight({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              controller: controller.weightC,
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Berat Barang',
                hintText: 'Masukkan Input Berat Barang Kg/Gram',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                if (value != '' || value != '0.0') {
                  controller.changeWeight(value);
                  controller.isCourer.value = false;
                  controller.isHideButton.value = true;
                }
                if (value == '' || value == '0') {
                  controller.isHideButton.value = true;
                  controller.isCourer.value = true;
                  controller.service.value = "";
                  controller.costs.value = "";
                  controller.days.value = "";
                }
              },
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 110,
            child: DropdownSearch<String>(
              popupProps: PopupProps.bottomSheet(
                showSelectedItems: true,
              ),
              items: ["Gram", "Kg", "Ton"],
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Unit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onChanged: (value) => controller.changeUnit(value.toString()),
              selectedItem: "Gram",
            ),
          )
        ],
      ),
    );
  }
}
