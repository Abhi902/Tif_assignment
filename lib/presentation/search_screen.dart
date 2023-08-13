import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tif_assignment/blocs/bloc/event_bloc.dart';

import 'event_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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

  String formatDate(DateTime dateTime) {
    String day = DateFormat.E().format(dateTime);
    String month = DateFormat.MMM().format(dateTime);
    String dayOfMonth = DateFormat.d().format(dateTime);
    String time = DateFormat.jm().format(dateTime);

    return '$day, $month $dayOfMonth • $time';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 30,
              child: Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Search',
                      style: TextStyle(
                        color: const Color(0xFF110C26),
                        fontSize: 24.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty || value.isEmpty) {
                  context.read<EventBloc>().add(FetchDetailsStart());
                }

                context
                    .read<EventBloc>()
                    .add(SearchEventTriggered(searchString: value));
              },
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              cursorColor: const Color(0xff7974E7),
              decoration: InputDecoration(
                prefixIcon: Container(
                  height: 25.h,
                  width: 25.w,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.asset(
                    'assets/searchScreen.png',
                    color: const Color(0xff5669FF),
                  ),
                ),
                hintText: 'Type Event Name',
                hintStyle: TextStyle(
                  color: const Color(0xff747688),
                  fontSize: 20.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<EventBloc, EventState>(
                    builder: (context, state) {
                      if (state is EventFetched) {
                        return ListView.builder(
                          itemCount: state.events.content.data.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EventDetail(
                                      eventData:
                                          state.events.content.data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 327,
                                  height: 106,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x0F575C8A),
                                        blurRadius: 35,
                                        offset: Offset(0, 10),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 79.w,
                                        height: 92.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: NetworkImage(state
                                                .events
                                                .content
                                                .data[index]
                                                .organiserIcon),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            formatDate(state.events.content
                                                .data[index].dateTime),
                                            style: TextStyle(
                                              color: const Color(0xFF5668FF),
                                              fontSize: 13.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 193.w,
                                            child: Text(
                                              state.events.content.data[index]
                                                  .title,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: const Color(0xFF110C26),
                                                fontSize: 15.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (state is SearchCompleted) {
                        return ListView.builder(
                          itemCount: state.events.content.data.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EventDetail(
                                      eventData:
                                          state.events.content.data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 327.w,
                                  height: 106.h,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x0F575C8A),
                                        blurRadius: 35,
                                        offset: Offset(0, 10),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 79.w,
                                        height: 92.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.white,
                                          image: DecorationImage(
                                            image: NetworkImage(state
                                                .events
                                                .content
                                                .data[index]
                                                .organiserIcon),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            formatDate(state.events.content
                                                .data[index].dateTime),
                                            style: TextStyle(
                                              color: const Color(0xFF5668FF),
                                              fontSize: 13.sp,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 193.w,
                                            child: Text(
                                              state.events.content.data[index]
                                                  .title,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: const Color(0xFF110C26),
                                                fontSize: 15.sp,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is SearchFailed) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25.sp,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "No Internet",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25.sp,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
