import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rajaongkir_project/app/data/models/province_model.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DropdownSearch<Province>(
        clearButtonProps: ClearButtonProps(isVisible: true),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: type == 'asal' ? 'Provinsi Asal' : 'Provinsi Tujuan',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        asyncItems: (String filter) async {
          try {
            Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
            var response = await http.get(
              url,
              headers: {'key': '511b05d05e36eea5da28ac3fc1065e5c'},
            );

            var data = json.decode(response.body) as Map<String, dynamic>;
            var statusCode = data['rajaongkir']['status']['code'];

            if (statusCode != 200) {
              throw data['rajaongkir']['status']['description'];
            }
            var listProvince = data['rajaongkir']['results'] as List<dynamic>;

            var models = Province.fromJsonList(listProvince);
            return models;
          } catch (e) {
            print(e);
            return List<Province>.empty();
          }
        },
        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "${item.province}",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            );
          },
        ),
        onChanged: (prov) {
          if (prov != null) {
            if (type == 'asal') {
              controller.isHideProv.value = false;
              controller.provId.value = int.parse(prov.provinceId.toString());
            } else {
              controller.isHideProvTo.value = false;
              controller.provIdTo.value = int.parse(prov.provinceId.toString());
            }
          } else {
            if (type == 'asal') {
              // controller.isHideProv.value = true;
              controller.isHideButton.value = true;
              controller.provId.value = 0;
            } else {
              // controller.isHideProvTo.value = true;
              controller.isHideButton.value = true;
              controller.provIdTo.value = 0;
            }
          }
        },
        itemAsString: (item) => item.province.toString(),
      ),
    );
  }
}
