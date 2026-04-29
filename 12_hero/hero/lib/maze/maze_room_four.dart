import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_five.dart';
import 'package:hero/other/trap_room.dart';
import 'package:hero/utils/maze_transitions.dart';
import 'package:hero/widgets/base_maze_room.dart';

class MazeRoomFour extends StatelessWidget {
  const MazeRoomFour({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseMazeRoom(
      roomTitle: "Maze Room Four",
      onDown: () =>
          Navigator.push(context, MazeTransitions.cover(const MazeRoomFive())),
      onRight: () =>
          Navigator.push(context, MazeTransitions.zoomSlide(const TrapRoom())),
      onLeft: () =>
          Navigator.push(context, MazeTransitions.page(const TrapRoom())),
      onUp: () =>
          Navigator.push(context, MazeTransitions.slide(const TrapRoom())),
    );
  }
}
