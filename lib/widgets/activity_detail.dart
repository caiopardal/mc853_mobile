import 'package:flutter/material.dart';
import 'package:inscritus/models/activity.dart';
import 'package:inscritus/models/location.dart';
import 'package:inscritus/models/speaker.dart';
import 'package:inscritus/services/database.dart';
import 'package:inscritus/widgets/speaker_item.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';

class ActivityDetail extends StatefulWidget {
  final Activity activity;
  final Location location;
  final String uid;
  final List<Speaker> speakers;

  ActivityDetail({
    this.activity,
    this.uid,
    this.speakers,
    this.location,
  });

  @override
  _ActivityDetailState createState() => _ActivityDetailState();
}

class _ActivityDetailState extends State<ActivityDetail> {
  bool isFavorite = false;
  bool isPreRegistered = false;

  @override
  void initState() {
    DatabaseService.checkIfActivityIsAlreadyFavorited(
      widget.uid,
      widget.activity.id,
    ).then((value) {
      setState(() {
        isFavorite = value;
      });
    });

    DatabaseService.checkIfActivityIsAlreadyPreRegistered(
      widget.uid,
      widget.activity.id,
    ).then((value) {
      setState(() {
        isPreRegistered = value;
      });
    });

    super.initState();
  }

  bool compareDate(String date) {
    var splittedDate = date.split('-');
    var month;

    var day = DateTime.now().toLocal().day.toString();
    var monthIndex = DateTime.now().toLocal().month;
    var year = DateTime.now().toLocal().year.toString();

    if (monthIndex < 10) month = '0' + monthIndex.toString();

    if (day == splittedDate[2] &&
        month == splittedDate[1] &&
        year == splittedDate[0]) {
      return true;
    }

    return false;
  }

  bool compareTime(String time) {
    var splittedNow = TimeOfDay.now().format(context).split(':');
    var splittedTime = time.split(':');

    var nowHour = int.parse(splittedNow[0]);
    var nowMinutes = int.parse(splittedNow[1]);
    var timeHour = int.parse(splittedTime[0]);
    var timeMinutes = int.parse(splittedTime[1]);

    if (nowHour >= timeHour) {
      if (nowHour == timeHour) {
        if (nowMinutes >= timeMinutes) return true;
      }

      return true;
    }

    return false;
  }

  void _openRegisterModal() async {
    await showDialog(
      context: context,
      builder: (BuildContext context, {barrierDismissible: false}) {
        return new AlertDialog(
          backgroundColor: Color(0xFF228B22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Icon(
            Icons.check_circle_outline,
            color: Color(0xFFfff5e8),
            size: 80.0,
          ),
          content: Text(
            "Deseja confirmar sua pré-inscrição nessa atividade?",
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFFfff5e8),
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              splashColor: Colors.yellow,
              height: 40.0,
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context, true);
              },
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'CANCELAR',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              splashColor: Colors.yellow,
              height: 40.0,
              color: Theme.of(context).primaryColorDark,
              onPressed: () async {
                setState(() {
                  isPreRegistered = true;
                });
                await DatabaseService.preRegisterToActivity(
                  widget.uid,
                  widget.activity.id,
                );

                Navigator.pop(context, true);
              },
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'CONFIRMAR',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  void _openUnsubscribeModal() async {
    return showDialog(
      context: context,
      builder: (BuildContext context, {barrierDismissible: false}) {
        return new AlertDialog(
          backgroundColor: Color(0xFFC85151),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Icon(
            Icons.warning,
            color: Color(0xFFfff5e8),
            size: 80.0,
          ),
          content: Text(
            "Tem certeza de que deseja se desinscrever dessa atividade?",
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFFfff5e8),
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              splashColor: Colors.yellow,
              height: 40.0,
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context, true);
              },
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'CANCELAR',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              splashColor: Colors.yellow,
              height: 40.0,
              color: Theme.of(context).primaryColorDark,
              onPressed: () async {
                setState(() {
                  isPreRegistered = false;
                });

                await DatabaseService.removeActivityFromPreRegistrations(
                  widget.uid,
                  widget.activity.id,
                );

                Navigator.pop(context, false);
              },
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'CONFIRMAR',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    var splittedRegistrationDate = widget.activity.registrationDate.split("-");
    var registrationDate = splittedRegistrationDate[2] +
        '/' +
        splittedRegistrationDate[1] +
        '/' +
        splittedRegistrationDate[0];

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
                        image: Image.network(
                          widget.location.imageUrl,
                        ),
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
                              widget.location.name,
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
                        top: 10,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tipo: ",
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
                              widget.activity.type,
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
                            "Capacidade máxima: ",
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
                              widget.activity.maxCapacity.toString(),
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
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: widget.activity.preRegistration ? 10 : 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Necessita inscrição? ",
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
                              widget.activity.preRegistration == false
                                  ? "Não"
                                  : "Sim",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.activity.preRegistration)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Abertura das inscrições",
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
                                registrationDate +
                                    ' - ' +
                                    widget.activity.registrationTime,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (widget.activity.preRegistration &&
                        compareDate(widget.activity.registrationDate) &&
                        compareTime(widget.activity.registrationTime))
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: GestureDetector(
                          onTap: !isPreRegistered
                              ? () => _openRegisterModal()
                              : () => _openUnsubscribeModal(),
                          child: Text(
                            !isPreRegistered
                                ? 'Clique aqui para registrar sua inscrição'
                                : 'Clique aqui para cancelar sua inscrição',
                            style: TextStyle(
                              fontSize: 20,
                              color:
                                  !isPreRegistered ? Colors.green : Colors.red,
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    if (widget.speakers.isNotEmpty)
                      Container(
                        height: _height * 1.07,
                        child: Padding(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  itemCount: widget.speakers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return SpeakerItem(
                                      speaker: widget.speakers[index],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        splashColor: Colors.yellow,
                        color: isFavorite
                            ? Colors.red
                            : Theme.of(context).primaryColorDark,
                        onPressed: !isFavorite
                            ? () async {
                                setState(() {
                                  isFavorite = true;
                                });
                                await DatabaseService.favoriteActivity(
                                  widget.uid,
                                  widget.activity.id,
                                );
                              }
                            : () async {
                                setState(() {
                                  isFavorite = false;
                                });

                                await DatabaseService
                                    .removeActivityFromFavorites(
                                  widget.uid,
                                  widget.activity.id,
                                );
                              },
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          isFavorite
                              ? 'Remover dos favoritos'
                              : 'Adicionar atividade aos favoritos',
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
