import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rajaongkir_project/app/modules/home/views/widgets/weight.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/city.dart';
import 'widgets/province.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ongkos Kirim Raja Ongkir'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            Provinsi(
              type: 'asal',
            ),
            Obx(
              () => controller.isHideProv.isTrue
                  ? SizedBox()
                  : Kota(
                      provId: controller.provId.value,
                      type: 'asal',
                    ),
            ),
            Provinsi(
              type: 'tujuan',
            ),
            Obx(
              () => controller.isHideProvTo.isTrue
                  ? SizedBox()
                  : Kota(
                      provId: controller.provIdTo.value,
                      type: 'tujuan',
                    ),
            ),
            Weight(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: DropdownSearch<Map<String, dynamic>>(
                clearButtonProps: ClearButtonProps(isVisible: true),
                popupProps: PopupProps.menu(
                  itemBuilder: (context, item, isSelected) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        '${item['name']}',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  },
                ),
                items: [
                  {'code': 'jne', 'name': 'Jalur Nugraha Ekakurir (JNE)'},
                  {'code': 'tiki', 'name': 'Titipan Kilat (Tiki)'},
                  {'code': 'pos', 'name': 'POS Indonesia'},
                ],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kurir / Ekspedisi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) {
                    controller.courier.value = value['code'];
                    controller.showButton();
                  } else {
                    controller.isHideButton.value = true;
                    controller.courier.value = "";
                  }
                },
                itemAsString: (item) => '${item['name']}',
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Obx(
                () => controller.isHideButton.isTrue
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () {},
                        child: Text('Cek Ongkir'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
