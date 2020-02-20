import 'package:flutter/material.dart';
import 'package:video_games_list/utils/consts.dart';
import 'package:video_games_list/widgets/game-card-dialog-video.dart';

class GameCardDialog extends StatefulWidget {
  @override
  _GameCardDialogState createState() => _GameCardDialogState();
}

class _GameCardDialogState extends State<GameCardDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 500.0,
        margin: gameCardMargin,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            
            Container(
              decoration: circularBorder,
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 15.0,
                left: 5.0,
                right: 5.0
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Sekiro: Shadows Die Twice", style: header2Style),
                  Text("Activison | 2019-03-22", style: defaultTextStyleBold),
                ],
              ),
            ),

            GameCardDialogVideo(),

            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  padding: gameCardDialogDescription,
                  child: Text(
                    "Sekiro: Shadows Die Twice is a game about a ninja (or shinobi, as they call it), who is seeking revenge in the Sengoku era Japan.\n\n###Plot\nThe game is set in the 16th century in a fictionalized version of Japan. The main protagonist is a member of a shinobi clan. A samurai from the rival Ashina clan captured the protagonist's master, and the protagonist himself lost his arm trying to protect his leader. However, a sculptor of Buddha statues managed to replace the lost limb with an advanced prosthetic arm. The protagonist accepted a new name, Sekiro, meaning “one-armed wolf”. Now his goal is to avenge his clan and to save his leader from the hands of their enemies.\n\n###Gameplay\nThe player controls Sekiro from the third person view and navigates the character as he fights multiple enemies. Sekiro: Shadows Die Twice features an innovative combat system that doesn't use hit points. Instead, the opponents can be killed with a single precision strike. However, the player has to fight his or her way through the opponent's blocks and parries to land the deadly blow. The main character fights with his sword (katana) in the right hand, while his left hand can host a variety of upgrades, such as an ax, a torch, or a shield. The game also emphasizes stealth action. The player has to use a grappling hook to access multiple locations. Sekiro: Shadows Die Twice has no multiplayer.",
                    style: defaultTextStyle,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
