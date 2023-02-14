import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isHideProv = true.obs;
  var provId = 0.obs;
  var cityId = 0.obs;
  var isHideProvTo = true.obs;
  var provIdTo = 0.obs;
  var cityIdTo = 0.obs;
  var isHideButton = true.obs;
  var courier = "".obs;
  double weight = 0.0;
  String unit = 'Gram';

  late TextEditingController weightC;

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
