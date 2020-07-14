import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/widgets/speaker_item.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class ActivityDetail extends StatefulWidget {
  final Activity activity;

  ActivityDetail({
    this.activity,
  });

  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    Speaker speaker = Speaker(
      bio:
          "Meu nome é Caio Pardal. Tenho 21 anos de idade e sou natural de Guarulhos-SP. Atualmente, sou estudante de Engenharia de Computação na Universidade Estadual de Campinas e trabalho como Engenheiro de software na empresa DieselBank. Sou fascinado por tecnologia e inovação e acredito que no mundo atual, inovar e criar novas tecnologias são essenciais para o progresso da sociedade.",
      id: "fQri5oOhNjjm2abCnthe",
      imageURL:
          "https://avatars0.githubusercontent.com/u/43478950?s=460&u=75afd3ecf41a7c628d5b6a620aa6706c0307c849&v=4",
      name: "Caio Pardal",
      shortBio: "Software Engineer",
      social: {
        "email": "pardal.henrique@gmail.com",
        "facebook": "https://www.facebook.com/caio.henrique.90663",
        "github": "https://github.com/caiopardal",
        "instagram": "",
        "linkedIn":
            "https://www.linkedin.com/in/caio-henrique-pardal-2b7329166/",
        "twitter": "",
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalhes da atividade",
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: _height,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  right: 15.0,
                  left: 15.0,
                  bottom: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: PinchZoomImage(
                        image: Image.asset('assets/map/' +
                            widget.activity.mapImageName +
                            '.png'),
                        zoomedBackgroundColor:
                            Color.fromRGBO(255, 255, 255, 1.0),
                        hideStatusBarWhileZooming: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nome: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            width: _width * 0.9,
                            child: Text(
                              widget.activity.name,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Local: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            width: _width * 0.8,
                            child: Text(
                              widget.activity.local,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Descrição: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            width: _width * 0.8,
                            child: Text(
                              widget.activity.description,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Palestrante(s): ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SpeakerItem(
                            speaker: speaker,
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(
                          //     top: 4,
                          //   ),
                          //   width: _width * 0.8,
                          //   child: Text(
                          //     widget.activity.speakers[0] +
                          //         ', ' +
                          //         widget.activity.speakers[1],
                          //     style: TextStyle(
                          //       fontSize: 20,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        splashColor: Colors.yellow,
                        color: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        padding: const EdgeInsets.all(15.0),
                        child: const Text(
                          'Adicionar atividade aos favoritos',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
