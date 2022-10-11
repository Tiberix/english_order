import 'package:english_order/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_order/controllers/cart_controller.dart';

class TableCard extends StatelessWidget {
  const TableCard({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    CartController controll = context.read<CartController>();
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 5,
            color: Colors.grey,
          ),
        ],
      ),
      child: Card(
        color: const Color(0xFFF8F8F8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  const Icon(Icons.table_restaurant_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('Table ${index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.black54)),
                  ),
                ],
              ),
              subtitle: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(' Open Orders ',
                          style: Theme.of(context).textTheme.caption),
                    ),
                    Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: controll.getAnzBest(index + 1) == 0
                            ? Text(
                                controll.getAnzBest(index + 1).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              )
                            : Text(
                                controll.getAnzBest(index + 1).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              // alignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      controll.changeTisch(index + 1);
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('Order'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      controll.changeTisch(index + 1);
                      Navigator.pushNamed(context, '/Rechnung');
                    },
                    child: const Text('Check Out'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
