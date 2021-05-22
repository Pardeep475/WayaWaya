import 'package:flutter/material.dart';

Widget customTextButton({Function onTap, String title, Color shadow}) {
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: InkWell(
      onTap: onTap,
      child: Card(
        shadowColor: shadow ?? Colors.grey[400],
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}