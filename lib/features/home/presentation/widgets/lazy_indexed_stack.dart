import 'package:flutter/material.dart';

/// Builds tab content lazily: only the tab currently (or previously)
/// selected gets built. Once a tab is built it's kept alive in
/// [_builtPages] so switching back to it does NOT rebuild it or
/// recreate its BlocProvider/Cubit — avoiding duplicate fetches.
class LazyIndexedStack extends StatefulWidget {
  final int index;
  final List<WidgetBuilder> builders;

  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.builders,
  });

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  final Map<int, Widget> _builtPages = {};

  @override
  Widget build(BuildContext context) {
    if (!_builtPages.containsKey(widget.index)) {
      _builtPages[widget.index] = KeyedSubtree(
        key: ValueKey('home_tab_${widget.index}'),
        child: widget.builders[widget.index](context),
      );
    }

    return IndexedStack(
      index: widget.index,
      children: List.generate(
        widget.builders.length,
        (i) => _builtPages[i] ?? const SizedBox.shrink(),
      ),
    );
  }
}