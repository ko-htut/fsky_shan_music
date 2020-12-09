import 'package:flutter/material.dart';

class StatementPage extends StatefulWidget {
  StatementPage({Key key}) : super(key: key);

  @override
  _StatementPageState createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  String statement =
      "ယိၼ်းၸူမ်းၶွပ်ႈၸႂ်ထိုင်ၽူႈၸႂ်ႉတိုဝ်း F-SKY Music Appႁဝ်းၶဝ်ၵူႈ​​ၵေႃႉၶႃႈ​​ဢေႃးယိူင်းဢၢၼ်းတႄႉႁႂ်ႈၽူႈသူၼ်ၸႂ်ႁပ်ႉထွမ်ႇၽဵင်းပၢႆးမွၼ်းတႆးႁဝ်းလႆႈထွမ်ႇငၢႆႈလီလႄႈၸွင်ႇၶူင်ဢွၵ်ႇမႃးၶႃႈ​​ဢေႃႈ။သၢင်ႇမီးတီႈၽိတ်းတီႈပိူင်ႈၼႆၸိုင်ၶဵၼ်း​​တေႃႈပွႆႇဝၢင်းၶႂၢင်ႉပၼ်​​သေၵမ်းၶႃႈသၢင်ဝႃႈၶႂ်ႈပၼ်တၢင်းႁၼ်ထိုင်ၸိင်ၵပ်းသိုပ်ႇမႃးလႆႈတီႈ Facebook Page-F-SKY Music App ဢမ်ႇၼၼ်မၢႆၽူင်း PH-09422433323 လၢႆႈယူႇၶႃႈ SaiFa(F-SKY)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text("Statement")),
      body: SingleChildScrollView(
        child: Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(statement),
        )),
      ),
    );
  }
}
