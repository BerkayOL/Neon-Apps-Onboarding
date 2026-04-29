import 'package:flutter/material.dart';
import 'package:hero/maze/maze_room_six.dart';
import 'package:hero/other/trap_room.dart';
import 'package:hero/utils/maze_transitions.dart';
import 'package:hero/widgets/base_maze_room.dart';

class MazeRoomFive extends StatelessWidget {
  const MazeRoomFive({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseMazeRoom(
      roomTitle: "Maze Room Five",
      onLeft: () =>
          Navigator.push(context, MazeTransitions.page(const MazeRoomSix())),
      onRight: () =>
          Navigator.push(context, MazeTransitions.cover(const TrapRoom())),
      onDown: () =>
          Navigator.push(context, MazeTransitions.slide(const TrapRoom())),
      onUp: () =>
          Navigator.push(context, MazeTransitions.zoomSlide(const TrapRoom())),
    );
  }
}
