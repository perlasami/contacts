
import 'dart:io';

import 'package:flutter/material.dart';

class Contactwidget extends StatelessWidget{
  String image;
  String name;
  String email;
  String phone;
  final VoidCallback? onDelete;
  Contactwidget({required this.name,required this.image,required this.email,required this.phone,this.onDelete,});
  Widget _buildContactImage() {
    if (image.isEmpty) {
      return Image.asset(
        "assets/images/person2.jpg",
        fit: BoxFit.cover,
      );
    }
    if (image.startsWith("assets/")) {
      return Image.asset(
        image,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(image),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/person2.jpg",
          fit: BoxFit.cover,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 177,
          decoration: BoxDecoration(
            color: const Color(0XFFFFF1D4),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
              SizedBox(
              height: 150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: _buildContactImage(),
              ),),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0XFFFFF1D4),
                    ),
                    child:  Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.email_rounded,
                          color: Color(0xFF29384D),
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child:  Text(
                              email,
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0xFF29384D),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children:  [
                        Icon(
                          Icons.phone_in_talk,
                          color: Color(0xFF29384D),
                          size: 20,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            phone,
                            maxLines: 1,
                            style: TextStyle(
                              color: Color(0xFF29384D),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          onDelete?.call();

                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 16,
                        ),
                        label: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF93E3E),
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}