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
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
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
            Obx(
              () => controller.isHide.isTrue
                  ? SizedBox()
                  : Provinsi(
                      type: 'tujuan',
                    ),
            ),
            Obx(
              () => controller.isHideProvTo.isTrue
                  ? SizedBox()
                  : Kota(
                      provId: controller.provIdTo.value,
                      type: 'tujuan',
                    ),
            ),
            Obx(
              () => controller.isWeight.isTrue ? SizedBox() : Weight(),
            ),
            Obx(
              () => controller.isCourer.isTrue
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: DropdownSearch<Map<String, dynamic>>(
                        clearButtonProps: ClearButtonProps(isVisible: true),
                        popupProps: PopupProps.menu(
                          itemBuilder: (context, item, isSelected) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
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
                          {
                            'code': 'jne',
                            'name': 'Jalur Nugraha Ekakurir (JNE)'
                          },
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
                            controller.service.value = "";
                            controller.costs.value = "";
                            controller.days.value = "";
                          }
                        },
                        itemAsString: (item) => '${item['name']}',
                      ),
                    ),
            ),
            Obx(
              () => controller.isOngkir.isTrue
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Layanan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('${controller.service}'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Harga Ongkir',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Rp. ${controller.costs}'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Estimasi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(controller.code.value == 'pos'
                                    ? '${controller.days}'
                                    : '${controller.days} Hari'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Obx(
                () => controller.isHideButton.isTrue
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () => controller.cekOngkir(),
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
