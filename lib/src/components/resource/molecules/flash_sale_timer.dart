import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/time/time_formatter.dart';
import '../../../general/constants/app_colors.dart';

class FlashSaleTimer extends StatefulWidget {
  const FlashSaleTimer({super.key});
  @override
  _FlashSaleTimerState createState() => _FlashSaleTimerState();
}

class _FlashSaleTimerState extends State<FlashSaleTimer> {
  late Timer timer;
  TimerDto dto = TimerDto(day: '00',hour: '00',minutes: '00',second: '00',);
  DateTime targetDateTime = DateTime(0,0,0,0);
  // Đối tượng DateTime mục tiêu

  @override
  void initState() {
    super.initState();
    _convertTime();
  }
  void _timeConvert({required Duration duration}){
    dto = AppConvert.timeConvert(duration: targetDateTime.difference(DateTime.now()));
  }

  void _convertTime() {
    _count();
  }

  void _count(){
    // Tạo một timer để cập nhật giao diện mỗi giây
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        // Lấy thời gian hiện tại
        DateTime now = DateTime.now();
        targetDateTime = DateTime(now.year, now.month, now.day, 23, 59, 59); // Cuối ngày hiện tại (23:59:59)
        // Tính toán khoảng thời gian còn lại
        Duration remainingTime = targetDateTime.difference(now);
        //convert date time => day,hour...
        _timeConvert(duration:remainingTime);

        // Kiểm tra xem đã đạt được thời gian mục tiêu chưa
        if (remainingTime == 0 ) {
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


  @override
  Widget build(BuildContext context) {
    return customTime();
  }

  Widget customTime(){
    return targetDateTime.isAfter(DateTime.now()) && dto != null ?
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
      color: AppColors.black03,
      borderRadius: BorderRadius.circular(AppGap.r6),
    ),
    child: Text(
      time,
      style: AppStyles.text5014(color: AppColors.yellow600Color),
    ) ,
  );
  Widget _space()=>Text(
    ':',
    style: AppStyles.text7016(),
  );
}