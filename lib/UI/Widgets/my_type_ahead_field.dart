import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MyTypeAheadField<T> extends StatelessWidget {
  final TextEditingController typeAheadController;
  final ValueChanged<String> onChanged;
  final FutureOr<Iterable<T>> Function(String) searchItems;
  final Widget Function(BuildContext, Object?) itemBuilder;
  final void Function(Object?) onSuggestionSelected;
  final AxisDirection direction;
  final int minInputLengthForSearch;

  const MyTypeAheadField(
      {Key? key,
      required this.typeAheadController,
      required this.onChanged,
      required this.searchItems,
      required this.direction,
      this.minInputLengthForSearch = 13,
      required this.itemBuilder,
      required this.onSuggestionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconButton clearButton = IconButton(
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          typeAheadController.clear();
          typeAheadController.text = "";
          onChanged("");
        });

    IconButton searchButton =
        IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black));

    return TypeAheadField(
      key: key,
      debounceDuration: const Duration(milliseconds: 500),
      direction: direction,
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          textInputAction: TextInputAction.unspecified,
          onChanged: (code) {
            onChanged(code);
          },
          style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suffixIcon: clearButton,
            prefixIcon: searchButton,
          ),
          controller: typeAheadController),
      suggestionsCallback: (pattern) async {
        var result = await searchItems(pattern);
        return result;
      },
      itemBuilder: itemBuilder,
      onSuggestionSelected: onSuggestionSelected,
    );
  }
}
