import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart' as launcher;

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
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: context.sw600 ? 400.0 : 600.0),
      child: Form(
        child: Column(
          children: [
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                decoration: InputDecoration(
                  labelText: 'Ваше имя',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                decoration: InputDecoration(
                  labelText: 'Номер телефона',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 32.0),
            MessageCard(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: context.sp(StyleRes.head36Title),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: context.sp(StyleRes.content32Blue),
                  fillColor: Colors.transparent,
                ),
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
                onPressed: () {},
              ),
            ),
            SizedBox(height: 32.0),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Нажимая кнопку, вы соглашаетесь с ',
                style: context.sp(StyleRes.content20Blue),
              ),
              TextSpan(
                text: 'офертой',
                style: context.sp(StyleRes.content20Blue.copyWith(decoration: TextDecoration.underline)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('oferta');
                    if (kIsWeb) {
                      html.window.open(
                        'https://storage.googleapis.com/surf-site-mediastore/media/education-docs/oferta-new.pdf',
                        'оферта',
                      );
                      return;
                    }
                    launcher.launch(
                        'https://storage.googleapis.com/surf-site-mediastore/media/education-docs/oferta-new.pdf');
                  },
              ),
              TextSpan(
                text: ' и ',
                style: context.sp(StyleRes.content20Blue),
              ),
              TextSpan(
                text: 'политикой конфиденциальности',
                style: context.sp(StyleRes.content20Blue.copyWith(decoration: TextDecoration.underline)),
              ),
            ])),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
