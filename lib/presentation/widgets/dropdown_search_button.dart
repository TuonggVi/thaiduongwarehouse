import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

// ignore: must_be_immutable
class DropdownSearchButton extends StatefulWidget {
  String buttonName;
  double width, height;
  List<String> listItem;
  String reference;
  VoidCallback onChanged;
  DropdownSearchButton(
      {super.key,
      required this.buttonName,
      required this.height,
      required this.width,
      required this.listItem,
      required this.reference,
      required this.onChanged});

  @override
  State<DropdownSearchButton> createState() => _DropdownSearchButtonState();
}

class _DropdownSearchButtonState extends State<DropdownSearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5 * SizeConfig.ratioHeight),
      width: widget.width * SizeConfig.ratioWidth,
      height: widget.height * SizeConfig.ratioHeight,
      padding: EdgeInsets.symmetric(vertical: 5 * SizeConfig.ratioHeight),
      decoration: BoxDecoration(
        color: Constants.buttonColor,
          border: Border.all(width: 1, color:Constants.buttonColor),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: DropdownSearch(
        dropdownSearchDecoration: InputDecoration(
            labelText: widget.buttonName,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 25 * SizeConfig.ratioFont,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10 * SizeConfig.ratioHeight),
           // hintText: "Chọn một thông số",
           // hintStyle: TextStyle(fontSize: 16 * SizeConfig.ratioFont),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
            fillColor: Colors.blue),
        showAsSuffixIcons: true,
        popupTitle: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
           widget.buttonName,
            style: TextStyle(fontSize: 16 * SizeConfig.ratioFont),
            textAlign: TextAlign.center,
          ),
        ),
        popupBackgroundColor: Colors.grey[200],
        popupShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        items: widget.listItem,

        selectedItem: widget.reference,
        //searchBoxDecoration: InputDecoration(),
        onChanged: (String? data) {
          widget.onChanged;
          //widget.reference == data;
        },
        showSearchBox: true,
        //  autoFocusSearchBox: true,
      ),
    );
  }
}
