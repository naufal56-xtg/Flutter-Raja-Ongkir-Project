import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rajaongkir_project/app/data/models/ongkir_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var isHide = true.obs;
  var isWeight = true.obs;
  var isCourer = true.obs;
  var isHideProv = true.obs;
  var isHideProvTo = true.obs;
  var provId = 0.obs;
  var cityId = 0.obs;
  var provIdTo = 0.obs;
  var cityIdTo = 0.obs;
  var isHideButton = true.obs;
  var courier = "".obs;
  var isDouble = 0.0.obs;
  var isOngkir = true.obs;

  var service = ''.obs;
  var costs = ''.obs;
  var days = ''.obs;
  var code = ''.obs;
  double weight = 0.0;
  String unit = 'Gram';

  late TextEditingController weightC;

  void cekOngkir() async {
    Uri url = Uri.parse('https://api.rajaongkir.com/starter/cost');

    try {
      final response = await http.post(
        url,
        body: {
          'origin': '$cityId',
          'destination': '$cityIdTo',
          'weight': '$weight',
          'courier': '$courier',
        },
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'key': '511b05d05e36eea5da28ac3fc1065e5c',
        },
      );

      var data = json.decode(response.body) as Map<String, dynamic>;
      var allOngkir = data['rajaongkir']['results'] as List<dynamic>;
      var listAllOngkir = Ongkir.fromJsonList(allOngkir);
      var ongkir = listAllOngkir[0];
      Get.defaultDialog(
        title: ongkir.name!,
        content: Column(
          children: ongkir.costs!
              .map(
                (e) => ListTile(
                  onTap: () {
                    service.value = e.service!;
                    costs.value = e.cost![0].value.toString();
                    days.value = e.cost![0].etd.toString();
                    code.value = ongkir.code!;
                    Get.back();
                    isOngkir.value = false;
                  },
                  title: Text(
                    '${e.service}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Rp. ${e.cost![0].value}'),
                  trailing: Text(ongkir.code == 'pos'
                      ? '${e.cost![0].etd}'
                      : '${e.cost![0].etd} Hari'),
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void showButton() {
    if (isHideProv != 0 && isHideProvTo != 0 && weight > 0 && courier != "") {
      isHideButton.value = false;
    } else {
      isHideButton.value = true;
    }
  }

  void changeWeight(String value) {
    weight = double.tryParse(value) ?? 0.0;
    String checkUnit = unit;
    switch (checkUnit) {
      case "Kg":
        weight = weight * 1000;
        break;
      case 'Gram':
        weight = weight;
        break;
      case 'Ton':
        weight = weight * 1000000;
        break;
      default:
        weight = weight;
    }
    showButton();
  }

  void changeUnit(String value) {
    weight = double.tryParse(weightC.text) ?? 0.0;
    switch (value) {
      case "Kg":
        weight = weight * 1000;
        break;
      case 'Gram':
        weight = weight;
        break;
      case 'Ton':
        weight = weight * 1000000;
        break;
      default:
        weight = weight;
    }

    unit = value;
    showButton();
  }

  @override
  void onInit() {
    weightC = TextEditingController(text: '$weight');
    super.onInit();
  }

  @override
  void onClose() {
    weightC.dispose();
    super.onClose();
  }
}
