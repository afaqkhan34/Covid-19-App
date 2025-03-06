import 'dart:convert';

import 'package:covid_19_app/modal/services/utilities/app_url.dart';
import 'package:covid_19_app/modal/world_states_model.dart';
import 'package:http/http.dart'as http;
class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecord() async {
    try {
      final response = await http.get(Uri.parse(AppUrl.worldStateApi));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('data fetched successfull $data');

        return WorldStatesModel.fromJson(data);
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}