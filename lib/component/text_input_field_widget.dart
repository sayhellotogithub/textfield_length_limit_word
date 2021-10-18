import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputFieldWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? textChanged;
  final bool obscureText;
  final Color hasFocusColor;
  final Color hitColor;
  final double fontSize;
  final int maxLines;
  final double lineHeight;
  final List<TextInputFormatter>? textInputFormatters;
  final ValueChanged<String>? onChanged;

  const TextInputFieldWidget(
      {Key? key,
      this.hintText = "",
      this.textChanged,
      this.obscureText = false,
      this.hasFocusColor = const Color(0xFF303133),
      this.hitColor = const Color(0xFFC0C4CC),
      this.fontSize = 14,
      this.lineHeight = 1,
      this.maxLines = 1,
      this.onChanged,
      this.textInputFormatters})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextInputFieldWidgetState();
  }
}

class _TextInputFieldWidgetState extends State<TextInputFieldWidget> {
  final _textEditingController = TextEditingController();
  String inputText = "";
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _textEditingController.addListener(_handleTextInput);
    super.initState();
  }

  void _handleTextInput() {
    widget.textChanged?.call(_textEditingController.text);
    setState(() {
      inputText = _textEditingController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      controller: _textEditingController,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      inputFormatters: [...?widget.textInputFormatters],
      style: TextStyle(
          fontSize: widget.fontSize,
          height: widget.lineHeight,
          color: _focusNode.hasFocus ? widget.hasFocusColor : widget.hitColor),
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: widget.hitColor,
          height: widget.lineHeight,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
