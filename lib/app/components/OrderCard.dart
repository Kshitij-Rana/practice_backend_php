import 'package:flutter/material.dart';
import 'package:getxpractice/app/components/constants.dart';
import 'package:getxpractice/app/model/order.dart';
import 'package:getxpractice/app/utils/Memorymanagement.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5, color: Colors.grey.shade200, spreadRadius: 5)
          ]),
      height: MemoryManagement.getAccessRole() == 'admin' ? 125 : 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#' + order.orderId.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                formatDate(order.orderDate),
                style: TextStyle(fontSize: 15, color: Colors.blue),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order.status == 'paid' ? 'paid' : 'failed',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: order.status == 'paid' ? Colors.green : Colors.red),
              ),
              Text(
                'Rs ' + order.total.toString(),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    );
  }
}
