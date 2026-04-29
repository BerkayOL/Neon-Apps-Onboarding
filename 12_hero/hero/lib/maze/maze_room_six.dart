import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_seven.dart';
import 'package:hero/other/trap_room.dart';
import 'package:hero/utils/maze_transitions.dart';
import 'package:hero/widgets/base_maze_room.dart';

class MazeRoomSix extends StatelessWidget {
  const MazeRoomSix({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseMazeRoom(
      roomTitle: "Maze Room Six",
      onUp: () =>
          Navigator.push(context, MazeTransitions.slide(const MazeRoomSeven())),
      onRight: () =>
          Navigator.push(context, MazeTransitions.cover(const TrapRoom())),
      onDown: () =>
          Navigator.push(context, MazeTransitions.page(const TrapRoom())),
      onLeft: () =>
          Navigator.push(context, MazeTransitions.zoomSlide(const TrapRoom())),
    );
  }
}
