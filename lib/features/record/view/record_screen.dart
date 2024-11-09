import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../repositories/firebase/BookingService.dart';
import '../../../repositories/models/models.dart';
import '../widgets/widgets.dart';

@RoutePage()
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  //state
  int _currentValueRadio = 1;
  String? _selectedDate;
  String? _selectedTime;
  int _selectedTimeIndex = -1; // Добавляем переменную для хранения выбранного индекса времени
  final BookingService _bookingService = BookingService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> _availableTimes = ['14:00', '15:00', '16:00'];
  bool resetTime = false;

  @override
  void initState() {
    super.initState();
    _updateAvailableTimes();
  }

  void _updateAvailableTimes() async {
    if (_selectedDate != null) {
      List<BookingModel> occupiedSlots = await _bookingService.getOccupiedSlots(_selectedDate!);
      List<String> occupiedTimes = occupiedSlots.map((booking) => booking.time).toList();
      setState(() {
        _selectedTime = null;
        _selectedTimeIndex = -1; // Сбрасываем выбранный индекс времени
        _availableTimes = ['14:00', '15:00', '16:00'];
        _availableTimes = _availableTimes.where((time) => !occupiedTimes.contains(time)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _startOfWeek = getStartOfWeek(DateTime.now());
    final _generateDatesForTwoWeeks = generateDatesForTwoWeeks(_startOfWeek);
    final _datesToString = datesToString(_generateDatesForTwoWeeks);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Чи100та в Кампусе'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Выберите дату:'),
              SizedBox(
                height: 100,
                child: HorizontalListView(
                  items: _datesToString,
                  selectIndex: -2,
                  onItemSelected: (date) {
                    setState(() {
                      _selectedTime = null;
                      _selectedTimeIndex = -1; // Сбрасываем выбранный индекс времени
                      _selectedDate = date;
                      _updateAvailableTimes();
                    });
                  },
                ),
              ),
              const Text('Выберите время:'),
              SizedBox(
                height: 50,
                child: HorizontalListView(
                  items: _availableTimes,
                  selectIndex: _selectedTimeIndex,
                  onItemSelected: (time) {
                    setState(() {
                      _selectedTime = time;
                      _selectedTimeIndex = _availableTimes.indexOf(time); // Сохраняем выбранный индекс времени
                    });
                  },
                ),
              ),
              const Text('Количество стиральных машин:'),
              Column(
                children: [
                  RadioListTile(
                    activeColor: Colors.black,
                    value: 1,
                    groupValue: _currentValueRadio,
                    onChanged: (value) {
                      setState(() {
                        _currentValueRadio = value!;
                      });
                    },
                    title: const Text('1 машина'),
                  ),
                  RadioListTile(
                    activeColor: Colors.black,
                    value: 2,
                    groupValue: _currentValueRadio,
                    onChanged: (value) {
                      setState(() {
                        _currentValueRadio = value!;
                      });
                    },
                    title: const Text('2 машины'),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedDate != null && _selectedTime != null) {
                        BookingModel booking = BookingModel(
                          userId: _auth.currentUser!.uid,
                          date: _selectedDate!,
                          time: _selectedTime!,
                          countMachine: _currentValueRadio,
                        );
                        _bookingService.createBooking(booking);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Пожалуйста, выберите дату и время')),
                        );
                      }
                    },
                    child: const Text('Забронировать', style: TextStyle(color: Colors.black, fontSize: 18),),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

}

List<String> datesToString(List<DateTime> dates) {
  List<String> ans = [];
  final DateFormat formatter = DateFormat('dd MMMM', 'ru');

  for (int i = 0; i < dates.length; i++) {
    final String dateString = formatter.format(dates[i]);
    ans.add(dateString);
  }
  return ans;
}

List<DateTime> generateDatesForTwoWeeks(DateTime date) {
  DateTime startOfWeek = getStartOfWeek(date);
  List<DateTime> dates = [];

  for (int i = 0; i < 14; i++) {
    DateTime currentDate = startOfWeek.add(Duration(days: i));
    if (!isWeekend(currentDate)) {
      dates.add(currentDate);
    }
  }

  return dates;
}

DateTime getStartOfWeek(DateTime date) {
  // Определяем день недели (1 - понедельник, 2 - вторник, ..., 7 - воскресенье)
  int dayOfWeek = date.weekday;

  // Вычисляем количество дней, которые нужно отнять, чтобы получить начало недели (понедельник)
  int daysToSubtract = dayOfWeek - 1;

  // Вычитаем дни, чтобы получить начало недели
  return date.subtract(Duration(days: daysToSubtract));
}

bool isWeekend(DateTime date) {
  // Проверяем, является ли день пятницей, субботой или воскресеньем
  int dayOfWeek = date.weekday;
  return dayOfWeek >= 5 && dayOfWeek <= 7;
}