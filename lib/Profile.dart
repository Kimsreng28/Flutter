import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String linkedInUrl =
      "https://www.linkedin.com/in/hai-kim-sreng-a0527b274/";
  final String emailUrl = "mailto:haikimsreng28@gmail.com";

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

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
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 238,
              width: 238,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/Kimsreng.JPG'),
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
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'HAI KIM SRENG\n',
                  style: TextStyle(
                    color: Color(0xFF7D79FD),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Mobile \n',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Developer\n',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            const Text(
              'I am a mobile developer. I love to learn new things and I am always looking for new opportunities to improve my skills.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 9),
            Column(
              children: [
                SizedBox(
                  width: 361,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrl(emailUrl);
                    },
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
                    onPressed: () {
                      _launchUrl(linkedInUrl);
                    },
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
      ),
    );
  }
}
