import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tif_assignment/blocs/bloc/event_bloc.dart';
import 'package:tif_assignment/presentation/event_details.dart';
import 'package:tif_assignment/presentation/search_screen.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
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
    context.read<EventBloc>().add(FetchDetailsStart());
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Events',
                      style: TextStyle(
                        color: const Color(0xFF110C26),
                        fontSize: 24.sp,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Search()));
                              },
                              child: Image.asset(
                                'assets/search.png',
                                width: 24.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(
                              'assets/menu.png',
                              width: 24.w,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
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
                                            height: 10.h,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 1.h),
                                                child: Icon(
                                                  Icons.location_on,
                                                  color:
                                                      const Color(0xFF747688),
                                                  size: 14.h,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              SizedBox(
                                                width: 200.w,
                                                child: Text(
                                                  '${state.events.content.data[index].venueName} • ${state.events.content.data[index].venueCity}, ${getAbbreviation(state.events.content.data[index].venueCountry)}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF747688),
                                                    fontSize: 13.sp,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "No Internet :_)",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
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
