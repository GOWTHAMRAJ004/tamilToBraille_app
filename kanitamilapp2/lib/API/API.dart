import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kanitamilapp2/screens/tamilToBraily.dart';

fetchdata (String url) async{
  http.Response response= await http.get(Uri.parse(url));
  return response.body;
}
