import 'package:flutter/material.dart';

class Validator{
  validator({required String text}){
    return
    (value) {
if (value == null || value.isEmpty) {
return text;
}
};

}
}