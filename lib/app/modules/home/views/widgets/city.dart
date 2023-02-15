import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rajaongkir_project/app/data/models/city_model.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    Key? key,
    required this.provId,
    required this.type,
  }) : super(key: key);

  final int provId;
  final String type;

  // final HomeController homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DropdownSearch<City>(
        clearButtonProps: ClearButtonProps(isVisible: true),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            label: type == 'asal'
                ? Text('Kota / Kabupaten Asal')
                : Text('Kota / Kabupaten Tujuan'),
          ),
        ),
        asyncItems: (String filter) async {
          try {
            Uri url = Uri.parse(
                "https://api.rajaongkir.com/starter/city?province=$provId");
            var response = await http.get(
              url,
              headers: {'key': '511b05d05e36eea5da28ac3fc1065e5c'},
            );

            var data = json.decode(response.body) as Map<String, dynamic>;
            var statusCode = data['rajaongkir']['status']['code'];

            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }
            var listCity = data['rajaongkir']['results'] as List<dynamic>;

            var models = City.fromJsonList(listCity);
            return models;
          } catch (e) {
            print(e);
            return List<City>.empty();
          }
        },
        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${item.type} ${item.cityName}",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            );
          },
        ),
        onChanged: (city) {
          if (city != null) {
            if (type == 'asal') {
              controller.cityId.value = int.parse(city.cityId.toString());
              controller.isHide.value = false;
            } else {
              controller.cityIdTo.value = int.parse(city.cityId.toString());
              controller.isHideProvTo.value = false;
              controller.isWeight.value = false;
            }
          } else {
            if (type == 'asal') {
              // controller.isHide.value = true;
              controller.isHideButton.value = true;
              controller.cityId.value = 0;
            } else {
              // controller.isWeight.value = true;
              controller.isHideButton.value = true;
              controller.cityIdTo.value = 0;
            }
          }
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
