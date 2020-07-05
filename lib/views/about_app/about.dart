import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class About extends StatelessWidget {
  static String routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              bottom: 25.0,
            ),
            child: Center(
              child: Image.asset(
                'assets/flutter_logo.png',
                height: 180.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Inscritus é um aplicativo open source voltado para a gestão de eventos. Aqui os participantes possuem acesso ao mapa do evento, às programações, aos palestrantes, às atividades e muito mais. Bem vindo!",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(25.0),
            child: new RichText(
              textAlign: TextAlign.center,
              text: new TextSpan(
                children: [
                  TextSpan(
                    text: 'Feito com',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0,
                    ),
                  ),
                  WidgetSpan(
                    child: FlutterLogo(size: 24.0),
                  ),
                  TextSpan(
                    text: 'Flutter & ❤️ por Caio Pardal e Leonardo Batista',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                ],
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SocialMediaCard(
                  onPressed: () => url_launcher
                      .launch('https://caio.pardal.github.io/personal-page'),
                  iconData: GroovinMaterialIcons.web,
                ),
                SocialMediaCard(
                  onPressed: () =>
                      url_launcher.launch('https://github.com/caiopardal'),
                  iconData: FontAwesomeIcons.github,
                ),
                // SocialMediaCard(
                //   onPressed: () => url_launcher.launch(FACEBOOK_PAGE_URL),
                //   iconData: FontAwesomeIcons.facebookSquare,
                // ),
                // SocialMediaCard(
                //   onPressed: () => url_launcher.launch(INSTAGRAM_PAGE_URL),
                //   iconData: FontAwesomeIcons.instagram,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialMediaCard extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  const SocialMediaCard({Key key, this.onPressed, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
            iconData,
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
