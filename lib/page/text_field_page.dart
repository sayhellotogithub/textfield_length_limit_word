import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:textfield_length_limit_word/component/max_word_textinput_formater.dart';
import 'package:textfield_length_limit_word/component/text_input_field_widget.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextFieldPageState();
  }
}

class TextFieldPageState extends State<TextFieldPage> {
  final Color _color = const Color(0xFFF5F6F7);
  int _count = 0;
  final int maxWordLength = 6;

  @override
  Widget build(BuildContext context) {
    return buildPage(_buildBody(), Text("TextField Max Words Limit"));
  }

  Widget _buildBody() {
    return Container(
        color: _color,
        child: Column(children: [
          const SizedBox(
            height: 12,
          ),
          _buildTextField()
        ]));
  }

  Widget _buildTextField() {
    return _buildContain(
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "TextField",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              _buildComputeMnemonic(),
            ],
          ),
          TextInputFieldWidget(
            textInputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[a-z\s_-]+")),
              MaxWordTextInputFormater(maxWords: 6)
            ],
            hintText: "please fill words ",
            maxLines: 4,
            lineHeight: 1.5,
          )
        ],
      ),
    );
  }

  Widget _buildComputeMnemonic() {
    return RichText(
        text: TextSpan(
            style: const TextStyle(fontSize: 14, color: Color(0xFF909399)),
            children: [
          const TextSpan(text: '('),
          TextSpan(
              text: _count.toString(),
              style: TextStyle(
                  color: _count > 0
                      ? const Color(0xFF5269FF)
                      : const Color(0xFF909399))),
          TextSpan(text: "/${maxWordLength.toString()})"),
        ]));
  }

  Scaffold buildPage(
    Widget body,
    Widget? titleWidget,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: _color,
        // status bar color
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: _color),
        foregroundColor: _color,
        shadowColor: Colors.transparent,
        title: titleWidget,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }

  Widget _buildContain(Widget child) {
    return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: child);
  }
}
