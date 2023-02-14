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
              onChanged: (value) => controller.changeWeight(value),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
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
