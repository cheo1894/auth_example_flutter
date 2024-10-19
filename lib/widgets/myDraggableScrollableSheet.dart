import 'package:flutter/material.dart';

myDraggableScrollableSheet(
    {required Widget widget,
    String title = '',
    void Function()? onClear,
    required DraggableScrollableController draggableScrollableController}) {
  return DraggableScrollableSheet(
    controller: draggableScrollableController,
    initialChildSize: 0.0,
    minChildSize: 0.0,
    maxChildSize: 0.9,
    expand: true,
    shouldCloseOnMinExtent: true,

    builder: (BuildContext context, ScrollController scrollController) {
      return PhysicalModel(
        elevation: 20,
        color: Colors.black,
        shadowColor: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.clear_rounded,
                      color: Colors.transparent,
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: onClear, child: Container(child: Icon(Icons.clear_rounded))),
                  ],
                ),
              ),
              Divider(
                color: Colors.black12,
              ),
              Expanded(
                child: SingleChildScrollView(
                  
                    padding: EdgeInsets.only(),
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: widget,
                    )),
              ),
            ],
          ),
        ),
      );
    },
  );
}
