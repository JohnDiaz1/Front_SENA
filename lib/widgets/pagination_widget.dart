import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.keyboard_arrow_left),
          ),
          ProductPageLabel(
            pageNo: 1,
            isCurrentPage: true,
          ),
          ProductPageLabel(pageNo: 2),
          ProductPageLabel(pageNo: 3),
          ProductPageLabel(pageNo: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}

class ProductPageLabel extends StatelessWidget {
  final dynamic pageNo;
  final bool? isCurrentPage;

  const ProductPageLabel({super.key, required this.pageNo, this.isCurrentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isCurrentPage ?? false ? Colors.blue : Colors.transparent),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Center(
          child: Text(
            "$pageNo",
            style: TextStyle(
                color: isCurrentPage ?? false ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }
}
