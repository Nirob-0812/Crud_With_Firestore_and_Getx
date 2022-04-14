import 'package:flutter/material.dart';

Custom_Snackbar(BuildContext context,String content){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}