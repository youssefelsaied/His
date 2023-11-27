import '../../../Theme/colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String? hint;
  final List<String> items;
  final IconData? prefixIcon;
  final Color? color;
  void Function(String?) onChanged;
  final TextEditingController? controller;
  String? initialValue;
  final String? endText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;

  CustomDropDown(
      {this.hint,
      this.prefixIcon,
      required this.items,
      required this.onChanged,
      this.endText,
      this.color,
      this.controller,
      this.initialValue,
      this.readOnly,
      this.textAlign,
      this.suffixIcon,
      this.textInputType,
      this.label,
      this.maxLines});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.label != null
            ? Text('\n' + widget.label! + '\n',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Color(
                      0xffb3b3b3,
                    ),
                    fontSize: 15))
            : SizedBox.shrink(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: width * .01),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).backgroundColor),
          width: width,
          child: Row(
            children: [
              widget.prefixIcon != null
                  ? SizedBox(
                      width: width * .1,
                      child: Icon(
                        widget.prefixIcon,
                        color: Theme.of(context).primaryColor,
                        size: 18.5,
                      ),
                    )
                  : Text(''),
              SizedBox(
                width: width * .78,
                child: DropdownButton<String>(
                  isExpanded: true,
                  items: widget.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: widget.onChanged,
                  underline: Text(''),
                  value: widget.initialValue,
                  hint: Text(
                    widget.hint!,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
