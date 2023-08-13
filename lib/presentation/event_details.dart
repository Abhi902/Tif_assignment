import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../model/event_model.dart';

// ignore: must_be_immutable
class EventDetail extends StatefulWidget {
  EventDetail({super.key, required this.eventData});

  Datum eventData;

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM, yyyy').format(dateTime);
  }

  String formatDateTime(DateTime dateTime) {
    String dayOfWeek = DateFormat.EEEE().format(dateTime);
    String startTime = DateFormat.jm().format(dateTime);

    DateTime endTime = dateTime.add(const Duration(
        hours: 5)); // For example, end time is 5 hours after start time
    String endTimeString = DateFormat.jm().format(endTime);

    return '$dayOfWeek, $startTime - $endTimeString';
  }

  String getAbbreviation(String input) {
    List<String> words = input.split(' ');

    if (words.length == 1) {
      return words[0].substring(0, 2).toUpperCase();
    } else if (words.length >= 2) {
      String firstLetters = words[0].substring(0, 1) + words[1].substring(0, 1);
      return firstLetters.toUpperCase();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 244.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: NetworkImage(widget.eventData.bannerImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    widget.eventData.title,
                    style: TextStyle(
                      color: const Color(0xFF110C26),
                      fontSize: 35.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Row(
                    children: [
                      Container(
                        width: 54.w,
                        height: 51.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(widget.eventData.organiserIcon),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.eventData.organiserName,
                            style: TextStyle(
                              color: const Color(0xFF0D0C26),
                              fontSize: 15.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.67,
                            ),
                          ),
                          Text(
                            'Organizer',
                            style: TextStyle(
                              color: const Color(0xFF6F6D8F),
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 28.h),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF5668FF).withOpacity(0.10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.calendar_month,
                          color: Color(0xff5669FF),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatDate(widget.eventData.dateTime),
                            style: TextStyle(
                              color: const Color(0xFF110C26),
                              fontSize: 16.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 2.12.h,
                            ),
                          ),
                          Text(
                            formatDateTime(widget.eventData.dateTime),
                            style: TextStyle(
                              color: const Color(0xff747688),
                              fontSize: 15.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.67.h,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 28.h),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF5668FF).withOpacity(0.10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xff5669FF),
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.eventData.venueName,
                            style: TextStyle(
                              color: const Color(0xFF0D0C26),
                              fontSize: 15.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.67,
                            ),
                          ),
                          Text(
                            '${widget.eventData.venueName} • ${widget.eventData.venueCity}, ${getAbbreviation(widget.eventData.venueCountry)}',
                            style: TextStyle(
                              color: const Color(0xFF6F6D8F),
                              fontSize: 12.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    'About Event',
                    style: TextStyle(
                      color: const Color(0xFF110C26),
                      fontSize: 18.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.89,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    widget.eventData.description,
                    style: TextStyle(
                      color: const Color(0xFF110C26),
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.75,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40.h,
            left: 15.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: 190.w,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/arrow_left.png',
                          width: 22.w,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          'Event Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.w,
                ),
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.30000001192092896),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
