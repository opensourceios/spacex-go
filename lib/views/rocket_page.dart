import 'package:cherry/classes/rocket_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:flutter/material.dart';

class RocketPage extends StatelessWidget {
  final RocketInfo rocket;

  RocketPage(this.rocket);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Rocket details'),
        ),
        body: Scrollbar(
            child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _RocketCard(rocket),
                  SizedBox(
                    height: 8.0,
                  ),
                  _SpecificationsCard(rocket),
                  SizedBox(
                    height: 8.0,
                  ),
                  _PayloadsCard(rocket),
                  SizedBox(
                    height: 8.0,
                  ),
                  _EnginesCard(rocket),
                ],
              ),
            )
          ],
        )));
  }
}

class _RocketCard extends StatelessWidget {
  final RocketInfo rocket;

  _RocketCard(this.rocket);

  @override
  Widget build(BuildContext context) {
    return HeadCardPage(
      head: Row(
        children: <Widget>[
          HeroImage().buildHero(
              context: context,
              size: 116.0,
              url: rocket.getImageUrl,
              tag: rocket.id,
              title: rocket.name),
          Container(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  rocket.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  rocket.getLaunchTime,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: secondaryText),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Success rate: ${rocket.getSuccessRate}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: secondaryText),
                ),
              ],
            ),
          )
        ],
      ),
      details: rocket.details,
    );
  }
}

class _SpecificationsCard extends StatelessWidget {
  final RocketInfo rocket;

  _SpecificationsCard(this.rocket);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'SPECIFICATIONS',
      body: <Widget>[
        RowItem.iconRow('Active', rocket.isActive),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Launch cost', rocket.getLaunchCost),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Rocket stages', rocket.getStages),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Height', rocket.getHeight),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Diameter', rocket.getDiameter),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Total mass', rocket.getMass),
      ],
    );
  }
}

class _PayloadsCard extends StatelessWidget {
  final RocketInfo rocket;

  _PayloadsCard(this.rocket);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'PAYLOAD',
      body: combineList(rocket.payloadWeights
          .map((payloadWeight) => getPayloadWeight(payloadWeight))
          .toList()),
    );
  }

  List<Widget> getPayloadWeight(PayloadWeight payloadWeight) {
    return <Widget>[
      RowItem.textRow(payloadWeight.name, payloadWeight.getMass),
      SizedBox(
        height: 12.0,
      )
    ];
  }

  List<Widget> combineList(List<List<Widget>> map) {
    final List<Widget> finalList = List();

    for (List<Widget> list in map)
      for (Widget widget in list) finalList.add(widget);

    return finalList..removeLast();
  }
}

class _EnginesCard extends StatelessWidget {
  final RocketInfo rocket;

  _EnginesCard(this.rocket);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'ENGINES',
      body: <Widget>[
        RowItem.textRow('Engine model', rocket.getEngine),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow(
            'First stage engines', rocket.engineConfiguration[0].toString()),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow(
            'Second stage engines', rocket.engineConfiguration[1].toString()),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Sea level thrust', rocket.getEngineThrustSea),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Vacuum thrust', rocket.getEngineThrustVacuum),
      ],
    );
  }
}
