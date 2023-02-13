import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rajaongkir_project/app/data/models/city_model.dart';
import 'package:flutter_rajaongkir_project/app/data/models/province_model.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/home_controller.dart';

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
            Provinsi(),
            Obx(
              () => controller.isHide.isFalse
                  ? SizedBox()
                  : Kota(
                      provId: controller.provId.value,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Provinsi extends StatefulWidget {
  const Provinsi({super.key});

  @override
  State<Provinsi> createState() => _ProvinsiState();
}

class _ProvinsiState extends State<Provinsi> {
  final HomeController homeC = Get.find();
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Province>(
      clearButtonProps: ClearButtonProps(isVisible: true),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          label: Text('Provisi'),
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
          homeC.isHide.value = true;
          homeC.provId.value = int.parse(prov.provinceId.toString());
        } else {
          homeC.isHide.value = false;
        }
      },
      itemAsString: (item) => item.province.toString(),
    );
  }
}

class Kota extends StatelessWidget {
  const Kota({
    Key? key,
    required this.provId,
  }) : super(key: key);

  final int provId;

  // final HomeController homeC = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: DropdownSearch<City>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            label: Text('Kota / Kabupaten'),
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
            city.cityName;
          } else {
            print('Tidak Ada Data Yang Dipilih');
          }
        },
        itemAsString: (item) => "${item.type} ${item.cityName}",
      ),
    );
  }
}
