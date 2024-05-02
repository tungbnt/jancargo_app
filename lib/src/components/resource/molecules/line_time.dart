import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jancargo_app/src/domain/dtos/time/time_formatter.dart';
import 'package:jancargo_app/src/general/constants/app_colors.dart';
import 'dart:async';

import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

class LineTimer extends StatefulWidget {
  const LineTimer({super.key, required this.dateString});

  final String dateString;
  @override
  State<LineTimer> createState() => _LineTimerState();
}

class _LineTimerState extends State<LineTimer> {
  late Timer timer;
  DateTime targetDateTime = DateTime.now(); // Đối tượng DateTime mục tiêu

  @override
  void initState() {
    super.initState();
    _convertTime();
  }

  void _convertTime() {
    // Chuỗi thời gian
    String dateTimeString = widget.dateString;


    targetDateTime = AppConvert.convertDateTime(dateString: dateTimeString);
    _countTimer();
  }

  void _countTimer(){
    // Tạo một timer để cập nhật giao diện mỗi giây
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        // Lấy thời gian hiện tại
        DateTime now = DateTime.now();
        // Tính toán khoảng thời gian còn lại
        Duration remainingTime = targetDateTime.isAfter(now)
            ? targetDateTime.difference(now)
            : const Duration(seconds: 0);

        // Kiểm tra xem đã đạt được thời gian mục tiêu chưa
        if (remainingTime.isNegative) {
          t.cancel(); // Dừng timer khi đạt thời gian mục tiêu
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Hủy timer khi widget bị dispose
    super.dispose();
  }

  String formatDuration(Duration duration) {
    return AppConvert.timeConvertLineTimer(duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.only(left: AppGap.w3),
          child: const Icon(Icons.access_time_sharp,size: 18,color: AppColors.white,),
        ),
        Text(
          formatDuration(targetDateTime.isAfter(DateTime.now())
              ? targetDateTime.difference(DateTime.now())
              : const Duration(seconds: 0)),
          style: AppStyles.text4012(color:  AppColors.white),
        ),
      ],
    );
  }
}

class LineAuctionTimer extends StatefulWidget {
  const LineAuctionTimer({super.key, required this.dateString});

  final String dateString;
  @override
  State<LineAuctionTimer> createState() => _LineAuctionTimer();
}

class _LineAuctionTimer extends State<LineAuctionTimer> {
  late Timer timer;
  DateTime targetDateTime = DateTime.now(); // Đối tượng DateTime mục tiêu
  TimerDto dto = TimerDto(day: '00',hour: '00',minutes: '00',second: '00',);
  @override
  void initState() {
    super.initState();
    _convertTime();
  }

  void _convertTime() {
    // Chuỗi thời gian
    String dateTimeString = widget.dateString;
    targetDateTime = AppConvert.convertDateTime(dateString: dateTimeString);
    //
    _countTimer();

  }
  void _timeConvert({required Duration duration}){
    dto = AppConvert.timeConvert(duration: targetDateTime.difference(DateTime.now()));
  }

  void _countTimer(){

    // Tạo một timer để cập nhật giao diện mỗi giây
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        // Lấy thời gian hiện tại
        DateTime now = DateTime.now();
        // Tính toán khoảng thời gian còn lại
        Duration remainingTime = targetDateTime.isAfter(now)
            ? targetDateTime.difference(now)
            : const Duration(seconds: 0);
        _timeConvert(duration: remainingTime);
        // Kiểm tra xem đã đạt được thời gian mục tiêu chưa
        if (remainingTime == 0) {
          t.cancel(); // Dừng timer khi đạt thời gian mục tiêu
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Hủy timer khi widget bị dispose
    super.dispose();
  }

  String formatDuration(Duration duration) {
    return AppConvert.timeConvertLineTimer(duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppGap.w10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.access_time_sharp,size: 18,color: AppColors.white,),
              Text('Kết thúc trong ',style: AppStyles.text5016(color: AppColors.white),),
            ],
          ),
          customTime(),
        ],
      ),
    );
  }

  Widget customTime(){
    return targetDateTime.isAfter(DateTime.now()) && dto.second!.isNotEmpty ?
    Row(
      children: [
        dto.day != '0N' ?
        _boxTimer(dto.day!) : const SizedBox.shrink(),
        dto.day != '0N' ? _space() : const SizedBox.shrink(),
        _boxTimer(dto.hour!),
        _space(),
        _boxTimer(dto.minutes!),
        _space(),
        _boxTimer(dto.second!),
      ],
    ) : Container();
  }

  Widget _boxTimer(String time)=> Container(
    height: AppGap.h24,
    width: AppGap.w24,
    padding: EdgeInsets.symmetric(horizontal: AppGap.w3),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: AppColors.white,
      borderRadius: BorderRadius.circular(AppGap.r6),

    ),
    child: Center(
      child: Text(
        time,
        style: AppStyles.text5014(color: AppColors.primary800Color),
      ),
    ) ,
  );
  Widget _space()=>Text(
    ':',
    style: AppStyles.text7016(color: AppColors.white),
  );
}