@extends('admin.layout')

@section('content')
<div class="page-header">
    <h4 class="page-title">{{ __('Calendar') }}</h4>
    <ul class="breadcrumbs">
        <li class="nav-home">
            <a href="{{ route('admin.dashboard') }}">
                <i class="flaticon-home"></i>
            </a>
        </li>
        <li class="separator">
            <i class="flaticon-right-arrow"></i>
        </li>
        <li class="nav-item">
            <a href="#">{{ __('Calendar') }}</a>
        </li>
    </ul>
</div>
<div id='calendar-container'>
    <div id='calendar'></div>
</div>
@endsection

@section('style')
    <style>
        #calendar {
            height: 600px;
            margin: 20px 0;
        }
        .fc-event {
            cursor: pointer;
        }
        .fc-toolbar-title {
            font-size: 1.5em;
        }
    </style>
@endsection

@section('script')
    <script src="{{ asset('calendar-20/dist/index.global.min.js') }}"></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                height: 'auto',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                },
                buttonText: {
                    today: 'Today',
                    month: 'Month',
                    week: 'Week',
                    day: 'Day',
                    list: 'List'
                },
                navLinks: true,
                editable: true,
                dayMaxEvents: true,
                events: @json($events),
                eventClick: function(info) {
                    // Handle event click
                    console.log('Event clicked:', info.event.title);
                },
                eventDrop: function(info) {
                    // Handle event drop (drag and drop)
                    console.log('Event dropped:', info.event.title);
                },
                eventResize: function(info) {
                    // Handle event resize
                    console.log('Event resized:', info.event.title);
                }
            });

            calendar.render();
        });
    </script>
@endsection
