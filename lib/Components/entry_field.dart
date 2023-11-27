import 'package:flutter/services.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:provider/provider.dart';

import '../../../../Theme/colors.dart';
import 'package:flutter/material.dart';

import '../Providers/auth.dart';

class EntryField extends StatefulWidget {
  final String? hint;
  final IconData? prefixIcon;
  final Color? color;
  final bool? border;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? readOnly;
  final bool? numbersOnly;
  final bool? autoCheck;
  final bool? obscure;
  final bool? allowSpace;
  final TextAlign? textAlign;
  final IconData? suffixIcon;
  final TextInputType? textInputType;
  final String? label;
  final int? maxLines;
  final int? maxLength;
  final Function? onTap;
  final String? Function(String?)? onValidate;
  final Function? onsuffixIconTap;
  final Function(String)? onchanged;
  final IconData? suffix;

  EntryField({
    this.hint,
    this.prefixIcon,
    this.color,
    this.border,
    this.controller,
    this.initialValue,
    this.readOnly,
    this.numbersOnly,
    this.autoCheck,
    this.obscure,
    this.allowSpace,
    this.textAlign,
    this.suffixIcon,
    this.textInputType,
    this.label,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.onValidate,
    this.onsuffixIconTap,
    this.onchanged,
    this.suffix,
  });

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        widget.label != null
            ? Text('\n' + widget.label! + '\n',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Color(0xff808080), fontSize: 15))
            : SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                maxLength: widget.maxLength ?? null,
                controller: widget.controller,
                initialValue: widget.initialValue,
                readOnly: widget.readOnly ?? false,
                obscureText: widget.obscure ?? false,
                maxLines: widget.maxLines ?? 1,
                validator: widget.onValidate,
                inputFormatters: widget.numbersOnly == null
                    ? []
                    : [
                        FilteringTextInputFormatter.digitsOnly,
                        // FilteringTextInputFormatter.allow(RegExp('[0-9,+]')),
                      ],
                onChanged: widget.onchanged,
                // (value) {
                //   if (widget.autoCheck != null) {
                //     if (widget.autoCheck!) {
                //       // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                //       auth.notifyListeners();
                //     }
                //   }
                //   if (widget.allowSpace != null) {
                //     print(widget.allowSpace);
                //     if (!widget.allowSpace!) {
                //       widget.controller!.text =
                //           widget.controller!.text.replaceAll(RegExp(r' '), '');
                //       // auth.notifyListeners();
                //     }
                //   }
                // },
                // textAlign: textAlign ?? TextAlign.right,
                keyboardType: widget.textInputType,
                decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: Theme.of(context).primaryColor,
                          size: 18.5,
                        )
                      : null,
                  suffixIcon: InkWell(
                    child: Icon(widget.suffixIcon),
                    onTap: () {
                      widget.onsuffixIconTap!();
                    },
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey.withOpacity(.8), fontSize: 16),
                  hintText: widget.hint,
                  filled: true,
                  fillColor: widget.color ?? Color(0xfff4f7f8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: widget.border != null
                        ? BorderSide(
                            color: Colors.grey.withOpacity(.1), width: .2)
                        : BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: widget.border != null
                        ? BorderSide(
                            color: Colors.grey.withOpacity(.7), width: 1)
                        : BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: widget.border != null
                        ? BorderSide(
                            color: Theme.of(context).primaryColor, width: 1)
                        : BorderSide.none,
                  ),
                ),
                onTap: widget.onTap as void Function()?,
              ),
            ),
            if (widget.suffix != null)
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 4),
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    widget.suffix,
                    color: Color(0xff0FC1A7),
                  ),
                ),
              )
          ],
        ),
      ],
    );
  }
}
