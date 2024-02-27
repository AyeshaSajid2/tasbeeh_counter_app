import 'package:flutter/material.dart';

class CountScreen extends StatefulWidget {
  final String tasbeehName;
  final int tasbeehCount;
  final Function(int) onCountUpdated;

  const CountScreen({
    Key? key,
    required this.tasbeehName,
    required this.tasbeehCount,
    required this.onCountUpdated,
  }) : super(key: key);

  @override
  State<CountScreen> createState() => _CountScreenState();
}

class _CountScreenState extends State<CountScreen> {
  bool isVolumeOn = true;
  int currentCount = 0;
  int totalCount = 33;
  int total = 0;
  bool isIncreasing = false;
  List<String> images = [
    'assets/images/bg6.jpg',
    'assets/images/bg2.jpg',
    'assets/images/bg3.jpg',
    'assets/images/bg4.jpg',
    'assets/images/bg5.jpg',
  ];
  List<double> opacities = [0.2, 0.2, 0.2, 0.2, 0.2]; // Initial opacity of the images
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasbeeh Counter",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 20,
        centerTitle: true,
        backgroundColor: Color(0xffd6a75f),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 100,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: toggleCount,
                      child: Image.asset(
                        'assets/images/bg1.jpg', // Use the first image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 160,
                    child: Container(
                      height: 80,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            "$currentCount",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                        width: 100,
                        height: 40,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 160,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: toggleVolume,
                          icon: Icon(
                            isVolumeOn ? Icons.volume_up : Icons.volume_off,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: toggleButton,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                isIncreasing ? "99" : totalCount.toString(),
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          onPressed: resetCount,
                          icon: Icon(
                            Icons.repeat_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 150,
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: SizedBox(
                        child: Center(
                          child: Text(
                            "Total: $total",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        width: 120,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: toggleCount,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: opacities[currentImageIndex],
              child: Container(
                height: 480,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[currentImageIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onCountUpdated(total);
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  void toggleVolume() {
    setState(() {
      isVolumeOn = !isVolumeOn;
    });
    // Add logic to toggle volume on/off
  }

  void toggleButton() {
    setState(() {
      isIncreasing = !isIncreasing;
      if (isIncreasing) {
        currentCount = 0;
      }
    });
  }

  // void toggleCount() {
  //   setState(() {
  //     currentCount++;
  //     total++;
  //     if (currentCount > widget.tasbeehCount) {
  //       currentCount = 0; // Reset currentCount to 0 when it exceeds the tasbeeh count
  //     }
  //     if (currentCount % totalCount == 0) {
  //       totalCount = (totalCount == 33) ? 93 : 33;
  //     }
  //     // Increase opacity of the second image on each click
  //     opacities[currentImageIndex] =
  //     opacities[currentImageIndex] + 0.1 <= 1.0 ? opacities[currentImageIndex] + 0.1 : 1.0;
  //   });
  // }
  void toggleCount() {
    setState(() {
      currentCount++;
      total++;
      if (currentCount > widget.tasbeehCount) {
        currentCount = 0; // Reset currentCount to 0 when it exceeds the tasbeeh count
      }
      if (currentCount % totalCount == 0) {
        totalCount = (totalCount == 33) ? 93 : 33;
      }

      // Increment opacity graduallygfirul
      double newOpacity = opacities[currentImageIndex] + 0.1;
      opacities[currentImageIndex] = newOpacity <= 1.0 ? newOpacity : 1.0;
    });
  }

  void resetCount() {
    setState(() {
      currentCount = 0;
      totalCount = 33;
      total = 0; // Reset total to 0 when reset button is clicked
      opacities[1] = 0.5; // Reset opacity of the second image
      currentImageIndex = (currentImageIndex + 1) % images.length; // Change image index for the second image
    });
  }
}
