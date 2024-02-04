import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:note_function/model/event.dart';

class CalenderPage extends StatefulWidget
{
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  late DateTime _showingDate = today;
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  List<Event> _getEventsForDay(DateTime day)
  {
    return events[day] ?? [];
  }

  @override
  void initState()
  {
    super.initState();
    _selectedDay = today;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
      (
        backgroundColor: Colors.grey,
        appBar: AppBar
                  (
                    title: const Text
                            ("Calender",
                              style: TextStyle
                                          (
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35
                                          ),
                            ),
                    centerTitle: true,
                  ),
        body: Column
                  (
                    children:
                        [
                          TableCalendar
                            (
                              locale: "en_US",
                              headerStyle: HeaderStyle(formatButtonVisible: false, titleCentered: true),
                              firstDay: DateTime.utc(2020,1,1),
                              lastDay: DateTime.utc(2030,12,31),
                              focusedDay: today,
                              selectedDayPredicate: (day)
                              {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay)
                              {
                                setState((){});
                                _selectedDay = selectedDay;
                                _showingDate = selectedDay;
                                today = focusedDay;
                                _selectedEvents.value = _getEventsForDay(selectedDay);
                              },
                            eventLoader: _getEventsForDay,
                            ),

                          Padding
                          (
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(height: 3,color: Colors.white,),
                          ),

                          Padding
                          (
                            padding: const EdgeInsets.symmetric(horizontal:40.0),
                            child: Row
                              (
                                children:
                                [
                                  Expanded(child: Text(_showingDate.toString().split(" ")[0],style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                                  IconButton(onPressed: (){}, icon: Icon(Icons.notifications),),
                                  IconButton
                                    (
                                      onPressed: ()
                                      {
                                        showDialog
                                          (
                                            context: context,
                                            builder: (context)
                                            {
                                              return AlertDialog
                                                (
                                                  scrollable: true,
                                                  title: Text("Event name"),
                                                  content: Padding
                                                            (
                                                              padding: EdgeInsets.all(8),
                                                              child: TextField
                                                                (
                                                                  controller: _eventController,
                                                                ),
                                                            ),
                                                  actions:
                                                  [
                                                    ElevatedButton
                                                      (
                                                        onPressed: ()
                                                        {
                                                          events.addAll({_selectedDay !: [Event(_eventController.text)]});
                                                          Navigator.of(context).pop();
                                                          _selectedEvents.value = _getEventsForDay(_selectedDay!);
                                                        },
                                                        child: Text("Submit")
                                                    )
                                                  ],
                                                );
                                            }
                                          );
                                      },
                                      icon: Icon(Icons.add)
                                    ),
                                ],
                              ),
                          ),

                          Expanded
                            (
                              child: ValueListenableBuilder<List<Event>>
                                (
                                  valueListenable: _selectedEvents,
                                  builder: (context, value, _)
                                    {
                                      return ListView.builder
                                        (
                                          itemCount: value.length,
                                          itemBuilder: (context, index)
                                              {
                                                return Container
                                                  (
                                                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                    decoration: BoxDecoration
                                                      (
                                                        border: Border.all(),
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                    child: ListTile
                                                      (
                                                        onTap: () => print(""),
                                                        title: Text('${value[index].title}'),
                                                      ),
                                                  );
                                              }
                                        );
                                    }
                                ),
                            )
                        ],
                  ),
      );
  }
}
