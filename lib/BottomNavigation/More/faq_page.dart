import 'package:animation_wrappers/animation_wrappers.dart';
import '../../../../Locale/locale.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class FAQ {
  String? question;
  String answer;

  FAQ(this.question, this.answer);
}

class _FAQPageState extends State<FAQPage> {
  List<double?> _isActive = [
    0,
    null,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    List<FAQ> _questionList = [
      FAQ(locale.faq1, locale.ans1!),
      FAQ(locale.faq2, locale.ans2!),
      FAQ(locale.faq3, locale.ans3!),
      FAQ(locale.faq4, locale.ans4!),
      FAQ(locale.faq5, locale.ans5!),
      FAQ(locale.faq6, locale.ans6!),
      FAQ(locale.faq7, locale.ans7!),
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.faqs!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        ListView.builder(
            itemCount: _questionList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isActive[index] = _isActive[index] == 0 ? null : 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text(
                        (index + 1).toString() +
                            '. ' +
                            _questionList[index].question!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    // duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.only(
                        left: 34, right: 34, top: 10, bottom: 10),
                    height: _isActive[index],
                    child: Text(
                      _questionList[index].answer,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15, color: Color(0xff666666)),
                    ),
                  ),
                  Divider(
                    thickness: 4,
                    color: Theme.of(context).backgroundColor,
                  ),
                ],
              );
            }),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
