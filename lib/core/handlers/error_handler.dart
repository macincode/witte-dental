import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            // color: Color(0xFF6C52A4), // matches your title color
            color: Colors.black,
          ),
          onPressed: Get.back,
        ),
        title: Text(
          'Error',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
        ),
        // centerTitle: true, // optional, to center the title
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: Get.back, // go back to previous page
                child: Text(
                  'Retry',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
