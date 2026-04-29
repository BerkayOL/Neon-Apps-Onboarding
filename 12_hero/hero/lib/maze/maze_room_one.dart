import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_two.dart';
import 'package:hero/other/trap_room.dart';
import 'package:hero/utils/maze_transitions.dart';
import 'package:hero/widgets/base_maze_room.dart';

class MazeRoomOne extends StatelessWidget {
  const MazeRoomOne({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseMazeRoom(
      roomTitle: "Maze Room One",
      onUp: () =>
          Navigator.push(context, MazeTransitions.slide(const MazeRoomTwo())),
      onDown: () =>
          Navigator.push(context, MazeTransitions.cover(const TrapRoom())),
      onLeft: () =>
          Navigator.push(context, MazeTransitions.page(const TrapRoom())),
      onRight: () =>
          Navigator.push(context, MazeTransitions.zoomSlide(const TrapRoom())),
    );
  }
}
