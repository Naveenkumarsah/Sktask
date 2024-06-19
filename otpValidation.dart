import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:task/detailPageOne.dart';

class OtpValidationPage extends StatefulWidget {
  @override
  _OtpValidationPageState createState() => _OtpValidationPageState();
}

class _OtpValidationPageState extends State<OtpValidationPage> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 103,
                  height: 74,
                  child: Image.network(
                    '',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 55.50,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                          letterSpacing: -3,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Verify phone number",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Check your SMS messages. We've sent you the CODE at  ",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            height: 1.5),
                      ),
                      TextSpan(
                        text: "+91 1234567890",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Pinput(
                  length: 6,
                  showCursor: true,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onCompleted: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (otpCode != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('OTP Verified: $otpCode')),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPageOne()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter 6-Digit code')),
                        );
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.lightGreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    child: Text('Verify', style: const TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive code?",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Resend Code",
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.green,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
