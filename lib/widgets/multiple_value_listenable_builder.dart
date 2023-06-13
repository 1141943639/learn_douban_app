import 'package:copy_to_app/utils/list_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultipleValueListenableBuilder extends StatefulWidget {
  MultipleValueListenableBuilder(
      {super.key,
      required this.multipleValueListenable,
      required this.builder,
      this.child});

  final ValueWidgetBuilder<List> builder;
  final Widget? child;
  final List<ValueListenable> multipleValueListenable;

  @override
  State<MultipleValueListenableBuilder> createState() =>
      _MultipleValueListenableBuilderState();
}

class _MultipleValueListenableBuilderState
    extends State<MultipleValueListenableBuilder> {
  List<void Function()> tempFunc = [];
  List values = [];

  @override
  void didUpdateWidget(covariant MultipleValueListenableBuilder oldWidget) {
    final needUpdate = oldWidget.multipleValueListenable.asMap().entries.any(
            (element) =>
                element.value ==
                widget.multipleValueListenable.at(element.key)) ||
        oldWidget.multipleValueListenable.length !=
            widget.multipleValueListenable.length;

    if (needUpdate) {
      handleMultipleValueListenable();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    clearListen();
    super.dispose();
  }

  @override
  void initState() {
    handleMultipleValueListenable();
    super.initState();
  }

  clearListen() {
    widget.multipleValueListenable.asMap().entries.forEach((element) {
      final oldFn = tempFunc.at(element.key);

      if (oldFn != null) element.value.removeListener(oldFn);
    });
  }

  handleMultipleValueListenable() {
    values = [];
    clearListen();
    tempFunc = [];

    widget.multipleValueListenable.asMap().entries.forEach((element) {
      final index = element.key;
      final value = element.value;
      final fn = _valueChange(index);

      tempFunc.add(fn);
      values.add(value.value);

      element.value.addListener(fn);
    });
  }

  void Function() _valueChange(index) {
    return () {
      setState(() {
        values[index] = widget.multipleValueListenable[index].value;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, values, widget.child);
  }
}
