import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_two.dart';
import 'package:hero/other/trap_room.dart';

class MazeRoomOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maze Room One'),
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontFamily: 'Antonio',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'avatar',
              child: Image(
                image: AssetImage('assets/images/avatar.png'),
                width: 200,
                height: 200,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrapRoom()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrapRoom()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_upward, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 600),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MazeRoomTwo(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              // Aşağıdan (y ekseninde 1.0) başlayıp merkeze (0.0) gelecek
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOutCubic;

                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child:
                                    child, // child burada MazeRoomTwo'yu temsil eder
                              );
                            },
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrapRoom()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
