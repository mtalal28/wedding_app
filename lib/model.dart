import 'package:flutter/material.dart';


class model extends StatefulWidget {
  const model({Key? key}) : super(key: key);

  @override
  State<model> createState() => _modelState();
}

class _modelState extends State<model
> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color(0xFF8D5765), // Change this to your desired color
            hintColor: const Color(0xFF8D5765),
            colorScheme: const ColorScheme.light(primary: Color(0xFF8D5765)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor:
                const Color(0xFF8D5765), // Change this to your desired color
            hintColor: const Color(0xFF8D5765),
            colorScheme: const ColorScheme.light(primary: Color(0xFF8D5765)),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        selectedDate = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F0F0),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: AdvancedSearchBar(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content vertically
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SmallBox(
                        child: Image.asset(
                          'assets/venue.png',
                          height: 25,
                        ),
                        onPressed: () {
                          // Handle click for 'assets/venue.png'
                          Navigator.pushNamed(context, '/venue'); // Replace with your navigation logic
                        },

                      ),
                      SmallBox(
                        child: Image.asset(
                          'assets/food.png',
                          height: 25,
                        ),
                        onPressed: () {

                          Navigator.pushNamed(context, 'food');
                        },

                      ),
                      SmallBox(
                        child: Image.asset(
                          'assets/model.png',
                          height: 25,
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'model');
                        },
                      ),
                      SmallBox(
                        child: Image.asset(
                          'assets/gallery.png',
                          height: 25,
                        ),
                        onPressed: () {

                          Navigator.pushNamed(context, '/gallery'); // Replace with your navigation logic
                        },

                      ),
                      SmallBox(
                        child: Image.asset(
                          'assets/bill.png',
                          height: 25,
                        ),
                        onPressed: () {

                          Navigator.pushNamed(context, '/bill'); // Replace with your navigation logic
                        },

                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 100),
                        child: Text(
                          'Beauty Specialist',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileBox(
                        image: 'assets/1.png',
                        name: 'John Doe',
                        specialty: 'Makeup Artist',
                        rating: 4.5,
                      ),
                      ProfileBox(
                        image: 'assets/2.png',
                        name: 'Jane Smith',
                        specialty: 'Hairstylist',
                        rating: 5.0,
                      ),
                      ProfileBox(
                        image: 'assets/3.png',
                        name: 'Alice Johnson',
                        specialty: 'Nail Technician',
                        rating: 4.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 130),
                        child: Text(
                          'Basic Package',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        PackageColumn(image: 'assets/nails.png'),
                        SizedBox(height: 15),
                        PackageColumn(image: 'assets/hair.png'),
                        SizedBox(height: 15),
                        PackageColumn(image: 'assets/eye.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 260),
                        child: Text(
                          'Date & Time',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF8D5765),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Select Date',
                                  hintStyle: const TextStyle(color: Color(0xFF8D5765)),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: Colors.black), // Default border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: Color(0xFF8D5765)), // Focused border color
                                  ),
                                  // prefixIcon: const SizedBox(width: 1),
                                  // suffixIcon: const SizedBox(width: 1),
                                ),
                                controller: TextEditingController(
                                  text: '${selectedDate.toLocal()}'.split(' ')[0],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => _selectTime(context),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF8D5765),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Select Time',
                                  hintStyle: const TextStyle(color: Color(0xFF8D5765)),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: Colors.black), // Default border color
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(color: Color(0xFF8D5765)), // Focused border color
                                  ),
                                  prefixIcon: const SizedBox(width: 15),
                                  suffixIcon: const SizedBox(width: 15),
                                ),
                                controller: TextEditingController(
                                  text: '${selectedDate.toLocal().hour}:${selectedDate.toLocal().minute}',
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Add some space between Date & Time input and Add to Cart button
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(bottom: 2),
                    // Move the "Sign In" button down
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        // Navigator.pushNamed(context, 'model');
                      },
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0xFF8D5765),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: const Color(0xFF8D5765),
                      textColor: Colors.white,
                      child: const Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdvancedSearchBar extends StatelessWidget {
  const AdvancedSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF8D5765)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.mic_sharp, color: Color(0xFF8D5765)),
                      onPressed: () {
                        // Handle search button press
                      },
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(12),
                  ),
                  cursorColor: const Color(0xFF8D5765),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Color(0xFF8D5765)),
                  onPressed: () {
                    // Handle cart button press
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



class SmallBox extends StatefulWidget {
  const SmallBox({Key? key, required this.child, required this.onPressed}) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  _SmallBoxState createState() => _SmallBoxState();
}

class _SmallBoxState extends State<SmallBox> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
        widget.onPressed(); // Call the onPressed callback when the box is clicked
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isClicked ? const Color(0xFF8D5765) : const Color(0xFFF9F0F0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}

class ProfileBox extends StatelessWidget {
  final String image;
  final String name;
  final String specialty;
  final double rating;

  const ProfileBox({
    Key? key,
    required this.image,
    required this.name,
    required this.specialty,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F0F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.transparent,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 80,

          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            specialty,
            style: const TextStyle(fontSize: 10, color: Color(0xFF8D5765)),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ), const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ), const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ), const Icon(
                Icons.star,
                color: Colors.amber,
                size: 12,
              ),
              Text(
                rating.toString(),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class PackageColumn extends StatelessWidget {
  final String image;

  const PackageColumn({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Image
        SizedBox(
          width: 45,
          height: 45,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8D5765),
              border: Border.all(
                color: Colors.transparent,
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                image,
                height: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        // Dotted Line
        Padding(
          padding: const EdgeInsets.only(right: 120),
          child: SizedBox(
            width: 1,
            height: 15,
            child: CustomPaint(
              painter: DottedLinePainter(numberOfDots: 20)
            ),
          ),
        ),
        const SizedBox(width: 15),
        // Price
        const Text(
          '\$50', // Replace with your actual price
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8D5765),
          ),
        ),
      ],
    );
  }
}
class DottedLinePainter extends CustomPainter {
  final int numberOfDots;

  DottedLinePainter({required this.numberOfDots});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    const double dotRadius = 1.5;
    const double gap = 4.0;

    for (int i = 0; i < numberOfDots; i++) {
      double x = i * (dotRadius * 2 + gap);
      canvas.drawCircle(Offset(x + dotRadius, size.height / 2), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Allow repainting
  }
}








