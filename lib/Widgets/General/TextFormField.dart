import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget textFormField(Function(String) _onChanged, String _hint, bool isReq,
    TextInputType _type, bool _obscureText, int _lines, String _initial,bool _readOnly) {
  return TextFormField(
    onChanged: _onChanged,
    initialValue: _initial,
    maxLines: _lines,
    readOnly: _readOnly,
    keyboardType: _type,
    obscureText: _obscureText,
    decoration: new InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      filled: true,
      fillColor: Colors.white,
      hintText: _hint,
      labelStyle: TextStyle(color: Color.fromRGBO(243, 119, 55, 1)),
      enabledBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(20.0),
        borderSide: new BorderSide(
            style: BorderStyle.solid, color: Color.fromRGBO(243, 119, 55, 0.5)),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(20.0),
        borderSide: new BorderSide(
            style: BorderStyle.solid, color: Color.fromRGBO(243, 119, 55, 0.5)),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(20.0),
        borderSide:
            new BorderSide(style: BorderStyle.solid, color: Colors.red[200]),
      ),
      errorBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(20.0),
        borderSide:
            new BorderSide(style: BorderStyle.solid, color: Colors.red[200]),
      ),
      errorStyle: TextStyle(
        color: Colors.red[200],
      ),
    ),
    validator: (text) {
      if (isReq && (text == null || text == "")) {
        return "Required";
      }
      return null;
    },
  );
}
