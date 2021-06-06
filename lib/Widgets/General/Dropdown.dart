import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orc_hr/Models/Project/DropdownItemModel.dart';

Widget dropdown(
    BuildContext context,
    DropDownListItem _value,
    String _hint,
    List<DropdownMenuItem<DropDownListItem>> _dropdownMenuItems,
    dynamic Function(DropDownListItem)  onChangeDropdownItem  ) {
  return DropdownButton(
    underline: Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(
        color: Color.fromRGBO(243, 119, 55, 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(243, 119, 55, 1),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: Color.fromRGBO(243, 119, 55, 1),
            blurRadius: 20.0,
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(243, 119, 55, 1),
            width: 1.0,
          ),
        ),
      ),
    ),
    hint: Text(
      _hint,
      style: TextStyle(fontSize: 16),
    ), // Not necessary for Option 1
    value: _value,
    onChanged: onChangeDropdownItem,
    items: _dropdownMenuItems,
  );
}
