library deta_pack;

import 'package:http/http.dart' as http;

class detaBase {
  String projectId;
  String apiKey;
  String basicUrl;
  Map<String, String> headers;
  detaBase(String key, String projectID) {
    this.projectId = projectID;
    this.apiKey = key;
    basicUrl = "https://database.deta.sh/v1/" + this.projectId;
    headers = {"content-type": "application/json", "x-api-key": apiKey};
  }
  getData(String base, String key) async {
    String url = basicUrl + '/' + base + '/items/' + key;
    return http.get(url, headers: headers);
  }

  putData(String base, String items) async {
    String url = basicUrl + '/' + base + '/items';
    return http.put(url, headers: headers, body: items);
  }

  deleteData(String base, String key) async {
    String url = '$basicUrl/$base/items/$key';
    return http.delete(url, headers: headers);
  }

  insertData(String base, String item) async {
    String url = '$basicUrl/$base/items';
    return http.post(url, headers: headers, body: item);
  }

  updateData(String base, String key, String update, String delete) {
    String url = '$basicUrl/$base/items/$key';
    String body = '"set":$update,"delete":[$delete]';
    return http.patch(url, headers: headers, body: body);
  }

  queryData(String base, String queries, int limit, String last) {
    String url = '$basicUrl/$base/query';
    String body = '"query":[$queries],"limit":$limit,"last":"$last"';
    return http.post(url, headers: headers, body: body);
  }
}