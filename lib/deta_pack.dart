library deta_pack;

import 'package:http/http.dart' as http;

class DetaBase {
  String projectId;
  String apiKey;
  Uri basicUrl;
  Map<String, String> headers;
  DetaBase(String key, String projectID) {
    this.projectId = projectID;
    this.apiKey = key;
    basicUrl = Uri.parse("https://database.deta.sh/v1/") + this.projectId;
    headers = {"content-type": "application/json", "x-api-key": apiKey};
  }

  /// This method lets you get data from your base.
  getData(String base, String key) async {
    String url = basicUrl + '/' + base + '/items/' + key;
    return http.get(Uri.parse(url), headers: headers);
  }

  /// This method let's you put new data items to your base. The 'items' argument is a string in JSON format.
  /// This method takes two arguments, onr the bse to put data into and then the list of items to be put in to the base.
  putData(String base, String items) async {
    String url = basicUrl + '/' + base + '/items';
    String body = '{"items":[$items]}';
    return http.put(Uri.parse(url), headers: headers, body: body);
  }

  /// This method is for deleting data objects from the base.
  /// This method takes two arguments, the base name and the key of the item to be deleted.
  deleteData(String base, String key) async {
    String url = '$basicUrl/$base/items/$key';
    return http.delete(Uri.parse(url), headers: headers);
  }

  /// This method adds an item to the base if the key does not already exist, i.e. creates a new item only if an item with the same key does not already exist.
  /// This method takes in two arguments, baseName and the item to be inserted. Only single items can be inserted.
  insertData(String base, String item) async {
    String url = '$basicUrl/$base/items';
    return http.post(Uri.parse(url), headers: headers, body: item);
  }

  /// This method lets you update specific fields of an existing item and also delete specific fields from the item.
  /// This method takes in four arguments, baseName, the key of the item to be modified, update string containing the data to be updated and the delete string containing the field to be deleted from the item.
  updateData(String base, String key, String update, String delete) {
    String url = '$basicUrl/$base/items/$key';
    String body = '"set":$update,"delete":[$delete]';
    return http.patch(Uri.parse(url), headers: headers, body: body);
  }

  /// This method lets you query data from the base. i.e. gets you data that matches given queries.
  /// This method takes two arguments, the base name, the query string,
  /// Optional parameters are limit( max the number of items to be listed that match the query ) and the 'last' key that was listed in the previous query.
  queryData(String base, String queries, {int limit, String last}) {
    String url = '$basicUrl/$base/query';
    String body = '"query":[$queries]';
    body += (limit != null) ? ',"limit":$limit' : '';
    body += (limit != null) ? ',"last":"$last"' : '';
    return http.post(Uri.parse(url), headers: headers, body: body);
  }
}
