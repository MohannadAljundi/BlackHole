/*
 *  This file is part of BlackHole (https://github.com/Sangwan5688/BlackHole).
 *
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Copyright (c) 2021-2023, Ankit Sangwan
 */

import 'package:flutter/material.dart';

class FadeTransitionPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Duration duration;
  final Curve curve;

  FadeTransitionPageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeOut,
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: curve,
    );

    return FadeTransition(
      opacity: curved,
      child: child,
    );
  }
}

class SlideTransitionPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final AxisDirection direction;
  final Duration duration;
  final Curve curve;

  SlideTransitionPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
    this.duration = const Duration(milliseconds: 250),
    this.curve = Curves.easeOut,
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  Offset _beginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, -1);
      case AxisDirection.down:
        return const Offset(0, 1);
      case AxisDirection.left:
        return const Offset(-1, 0);
      case AxisDirection.right:
        return const Offset(1, 0);
      default:
        // Future-proof: if Flutter adds new values later.
        assert(false, 'Unhandled AxisDirection: $direction');
        return const Offset(1, 0);
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: curve,
    );

    return SlideTransition(
      position: Tween<Offset>(begin: _beginOffset(), end: Offset.zero)
          .animate(curved),
      child: child,
    );
  }
}
