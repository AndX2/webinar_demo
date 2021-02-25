import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:http/http.dart' as http;

import 'package:webinar_demo/data.dart';
import 'package:webinar_demo/widget/message_card.dart';
import 'package:webinar_demo/util.dart';
import 'package:webinar_demo/widget/primary_btn.dart';

class SubmitForm extends StatefulWidget {
  SubmitForm({Key key}) : super(key: key);

  @override
  _SubmitFormState createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: context.sw600 ? 400.0 : 600.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Ваше имя',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
                keyboardType: TextInputType.text,
                validator: nameValidator,
              ),
            ),
            SizedBox(height: 32.0),
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Номер телефона',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
                keyboardType: TextInputType.phone,
                validator: phoneValidator,
              ),
            ),
            SizedBox(height: 32.0),
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
            ),
            SizedBox(height: 32.0),
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                decoration: InputDecoration(
                  labelText: 'Промокод на скидку',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(height: 48.0),
            Align(
              alignment: Alignment.topLeft,
              child: PrimaryBtn.legendary(
                // padding: EdgeInsets.all(10.0),
                child: Center(
                    child: Text(
                  'Записаться на курс',
                  style: context.sp(StyleRes.head40Title),
                )),
                onPressed: !_isLoading ? _submit : null,
              ),
            ),
            SizedBox(height: 32.0),
            Text.rich(TextSpan(children: [
              TextSpan(
                text: 'Нажимая кнопку, вы соглашаетесь с ',
                style: context.sp(StyleRes.content20Blue),
              ),
              TextSpan(
                text: 'офертой',
                style: context.sp(StyleRes.content20Blue.copyWith(decoration: TextDecoration.underline)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launcher.launch(
                      'https://storage.googleapis.com/surf-site-mediastore/media/education-docs/oferta-new.pdf'),
              ),
              TextSpan(
                text: ' и ',
                style: context.sp(StyleRes.content20Blue),
              ),
              TextSpan(
                text: 'политикой конфиденциальности',
                style: context.sp(StyleRes.content20Blue.copyWith(decoration: TextDecoration.underline)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launcher
                      .launch('https://storage.googleapis.com/surf-site-mediastore/media/education-docs/privacy.pdf'),
              ),
            ])),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    final validateResult = _formKey.currentState.validate();
    if (!validateResult) return;
    _isLoading = true;
    await http.post('https://forms.tildacdn.com/procces/', headers: {
      'sec-ch-ua': '"Chromium";v="88", "Google Chrome";v="88", ";Not A Brand";v="99"',
      'sec-ch-ua-mobile': '?0',
      'Upgrade-Insecure-Requests': '1',
      'Content-Type': 'application/x-www-form-urlencoded',
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.104 Safari/537.36',
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
      'Host': 'forms.tildacdn.com',
      'Origin': 'education.surf.ru/',
      'Referer': 'education.surf.ru/',
      'Sec-Fetch-Dest': 'document',
      'Sec-Fetch-Mode': 'navigate',
      'Sec-Fetch-Site': 'cross-site',
      'Sec-Fetch-User': '?1',
    }, body: {
      'Email': emailController.text,
      'Name': nameController.text,
      'Phone': phoneController.text,
      'form-spec-comments': 'Its good',
      'formservices':
          '074a316ead0a750e57ebdf5a7b3e63ba;e247b2c1ac6572febb1c0f39eaea423f;f8db067c4b51f19e39b7bfa43db260f6',
    }).then((response) {
      print(response);
      _formKey.currentState.reset();
    }).catchError((e) {
      print(e);
      _isLoading = false;
    });
    _isLoading = false;
  }
}

Function emailValidator = (String value) {
  if (value == null || value.isEmpty || !value.contains('@')) return 'Неверный формат eMail';
};

Function nameValidator = (String value) {
  if (value == null || value.length < 2) return 'Неверный формат имени';
};

Function phoneValidator = (String value) {
  if (value == null || value.length < 10) return 'Неверный формат телефона';
};
