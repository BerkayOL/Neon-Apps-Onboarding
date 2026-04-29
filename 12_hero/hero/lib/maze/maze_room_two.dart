import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_three.dart';
import 'package:hero/other/trap_room.dart';
import 'package:hero/utils/maze_transitions.dart';
import 'package:hero/widgets/base_maze_room.dart';

class MazeRoomTwo extends StatelessWidget {
  const MazeRoomTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseMazeRoom(
      roomTitle: "Maze Room Two",
      onRight: () => Navigator.push(
        context,
        MazeTransitions.zoomSlide(const MazeRoomThree()),
      ),
      onDown: () =>
          Navigator.push(context, MazeTransitions.cover(const TrapRoom())),
      onLeft: () =>
          Navigator.push(context, MazeTransitions.page(const TrapRoom())),
      onUp: () =>
          Navigator.push(context, MazeTransitions.slide(const TrapRoom())),
    );
  }
}
