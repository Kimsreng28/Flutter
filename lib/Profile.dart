import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.code,
          size: 30,
        ),
        title: const Text('Coder'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              size: 24,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Container(
            height: 238,
            width: 238,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://eu-central.storage.cloudconvert.com/tasks/87fa74e0-e605-413f-9be6-ec792fb2f36b/IMG_1039.webp?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=cloudconvert-production%2F20250316%2Ffra%2Fs3%2Faws4_request&X-Amz-Date=20250316T134718Z&X-Amz-Expires=86400&X-Amz-Signature=469d09359a100e307e69db1c1c8080bdf7edc15824ed0cef89215abe3aeab790&X-Amz-SignedHeaders=host&response-content-disposition=inline%3B%20filename%3D%22IMG_1039.webp%22&response-content-type=image%2Fwebp&x-id=GetObject'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'Welcome to my Portfolio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          const Text.rich(
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(height: 1),
            TextSpan(children: [
              TextSpan(
                text: 'Hi I’m \n',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'HAI KIM SRENG\n',
                style: TextStyle(
                  color: Color(0xFF7D79FD),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Mobile \n',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Developer\n',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          const Text(
            'Collaborating with highly skilled individuals, our agency delivers top-quality services.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 9),
          Column(
            children: [
              SizedBox(
                width: 361,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7D79FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Hire Me!",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              SizedBox(
                width: 361,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF7D79FD),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Download CV",
                        style: TextStyle(
                            color: Color(0xFF7D79FD),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.download, color: Color(0xFF7D79FD)),
                    ],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
