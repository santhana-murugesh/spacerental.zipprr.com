"use strict";

$(document).ready(function() {
    // Initialize date picker
    $('input[name="checkInDate"]').daterangepicker({
        singleDatePicker: true,
        autoUpdateInput: true,
        autoApply: true,
        minDate: moment().format('MM/DD/YYYY'), startDate: moment().format('MM/DD/YYYY'),
        isInvalidDate: function(date) {
            return holidays.includes(date.format('MM/DD/YYYY'));
        }
    });

    // Initialize time picker
    $('input[name="checkInTime"]').daterangepicker({
        opens: 'left',
        timePicker: true,
        singleDatePicker: true,
        autoApply: true,
        timePickerIncrement: 30, // Use 30-minute increments for better usability
        timePicker24Hour: timePicker,
        locale: {
            format: timeFormate
        }
    }).on('show.daterangepicker', function(ev, picker) {
        picker.container.find(".calendar-table").hide();
    });

    // Flag to prevent multiple AJAX calls
    let isProcessing = false;
    
    // Function to update prices
    function updatePrices() {
        if (isProcessing) return;
        
        isProcessing = true;
        $(".request-loader").addClass("show");
        
        const selectedDate = $('input[name="checkInDate"]').val();
        const selectedTime = $('input[name="checkInTime"]').val();
        
        // Update hidden fields
        $('#checkInDates').val(selectedDate);
        $('#checkInTimes').val(convertTo24Hour(selectedTime));
        
        // Prepare form data
        const fd = $('#searchForm').serialize();
        
        // Clear previous results
        $('.search-container').html('');
        
        // Make AJAX request
        $.ajax({
            url: searchUrl,
            method: "GET",
            data: fd,
            success: function(response) {
                $('.search-container').html(response);
            },
            error: function(xhr) {
                console.error("Error fetching prices:", xhr);
                // Show error message to user if needed
            },
            complete: function() {
                $('.request-loader').removeClass('show');
                isProcessing = false;
            }
        });
    }

    const debouncedUpdate = _.debounce(updatePrices, 300);
    
    $('input[name="checkInDate"]').on('change', debouncedUpdate);
    $('input[name="checkInTime"]').on('change', debouncedUpdate);

    function convertTo24Hour(time) {
        if (!time) return '';
        
        var timeArray = time.split(':');
        var hours = parseInt(timeArray[0]);
        var minutes = parseInt(timeArray[1]);
        var isPM = time.toLowerCase().indexOf('pm') > -1;

        if (isPM && hours < 12) {
            hours += 12;
        } else if (!isPM && hours === 12) {
            hours = 0;
        }

        return padZero(hours) + ':' + padZero(minutes) + ':00';
    }

    function padZero(num) {
        return (num < 10) ? '0' + num : num;
    }
});