import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light, // works
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
            child: Center(
              child: Text(
                "Inscritus é um aplicativo open source voltado para a gestão de eventos. Aqui os participantes possuem acesso ao mapa do evento, às programações, aos palestrantes, às atividades e muito mais. Bem vindo!",
                style: TextStyle(
                  fontFamily: 'RedHatDisplay',
                  color: Color(0xff333d47),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 24),
            child: Text(
              "Data e Horário",
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                color: Color(0xff333d47),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 24,
              left: 24,
              top: 16,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "O evento Inscritus ocorrerá no dia ",
                    style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      color: Color(0xff333d47),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: "24 de Agosto, Segunda ",
                    style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      color: Color(0xff333d47),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: "entre ",
                    style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      color: Color(0xff333d47),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  TextSpan(
                    text: "09:00 e 19:00",
                    style: TextStyle(
                      fontFamily: 'RedHatDisplay',
                      color: Color(0xff333d47),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 40),
            child: new Text(
              "Local",
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                color: Color(0xff333d47),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
            child: Container(
                height: 219,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage('assets/map.png'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    new BoxShadow(color: Colors.grey[200], blurRadius: 10.0)
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Stack(children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                              color: const Color(0xcc333d47)))),
                  PositionedDirectional(
                    top: 185,
                    start: 16,
                    child: Container(
                      height: 50,
                      child: Text("<nome_do_local>",
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "RedHatDisplay",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0)),
                    ),
                  ),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
            child: GestureDetector(
                child: (new Container(
                  height: 53,
                  decoration: new BoxDecoration(
                      color: Color(0xff3196f6),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: new Text(
                      "Ver no Google Maps",
                      style: TextStyle(
                        fontFamily: 'RedHatDisplay',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                )),
                onTap: () {
                  _launchURL(
                      "https://www.google.com/maps/place/Institute+of+Computing+-+IC+3+%2F+3.5+-+Unicamp/@-22.8160443,-47.0664927,17z/data=!4m8!1m2!2m1!1sic+unicamp!3m4!1s0x94c8c153684c9b8d:0x1aa3c51e3317b873!8m2!3d-22.8136593!4d-47.0638767");
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 40),
            child: new Text(
              "Organizadores",
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                color: Color(0xff333d47),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
            child: Container(
              width: 214,
              child: SvgPicture.asset(
                "assets/logo.svg",
                height: 60.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 16),
            child: Center(
              child: new Text(
                  "<Adicione aqui a descrição detalhada dos organizadores do evento>",
                  style: TextStyle(
                    fontFamily: 'RedHatDisplay',
                    color: Color(0xff333d47),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 40),
            child: new Text(
              "Redes sociais",
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                color: Color(0xff333d47),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                    child: Container(
                        height: 44.0, // height of the button
                        width: 44.0, // width of the button
                        child: Image.asset("assets/facebook.png",
                            fit: BoxFit.fill)),
                    onTap: () {
                      _launchURL("https://www.facebook.com/");
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: GestureDetector(
                      child: Container(
                        height: 44.0, // height of the button
                        width: 44.0, // width of the button
                        child: Image.asset("assets/instagram.png",
                            fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://www.instagram.com/");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: GestureDetector(
                      child: Container(
                        height: 44.0, // height of the button
                        width: 44.0, // width of the button
                        child:
                            Image.asset("assets/twitter.png", fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://twitter.com/");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: GestureDetector(
                      child: Container(
                        height: 44.0, // height of the button
                        width: 44.0, // width of the button
                        child: Image.asset("assets/linkedin.png",
                            fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://www.linkedin.com/");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: GestureDetector(
                      child: Container(
                        height: 44.0, // height of the button
                        width: 44.0, // width of the button
                        child:
                            Image.asset("assets/youtube.png", fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://www.youtube.com/");
                      }),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 24, top: 40),
            child: new Text(
              "Patrocinadores",
              style: TextStyle(
                fontFamily: 'RedHatDisplay',
                color: Color(0xff333d47),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16),
                  child: GestureDetector(
                      child: Container(
                        height: 44.0, // height of the button
                        child: Image.asset("assets/ic_google.png",
                            fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://developers.google.com/");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16),
                  child: GestureDetector(
                      child: Container(
                        height: 44.0, // height of the button
                        child: Image.asset("assets/ic_zeplin.png",
                            fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://zeplin.io/");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16),
                  child: GestureDetector(
                      child: Container(
                        height: 80.0, // height of the button
                        child: Image.asset("assets/ic_jetbrains.png",
                            fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://www.jetbrains.com/");
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: GestureDetector(
                      child: Container(
                        height: 120.0, // height of the button
                        child: Image.asset("assets/ic_gcloud.png",
                            fit: BoxFit.fill),
                      ),
                      onTap: () {
                        _launchURL("https://cloud.google.com/");
                      }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
