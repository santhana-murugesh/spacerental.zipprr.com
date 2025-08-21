"use strict";

// Setup CSRF token
$.ajaxSetup({
  headers: {
    'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
  }
});

// Initialize select2 dropdowns
$(document).ready(function () {
  for (let i = 1; i <= 8; i++) {
    $('.js-example-basic-single' + i).select2();
  }
});

// Load States based on Country selection
$('body').on('change', '.js-example-basic-single3', function () {
  const id = $(this).val();
  const lang = $(this).attr('data-code');
  const stateClass = lang + "_country_state_id";
  const stateHide = lang + "_hide_state";
  const cityClass = lang + "_state_city_id";

  $('.' + stateClass + ' option, .' + cityClass + ' option').remove();

  $.ajax({
    type: 'POST',
    url: getStateUrl,
    data: { id, lang },
    success: function (data) {
      if (data) {
        console.log(data);
        if (data.states && data.states.length > 0) {
          $('.' + stateHide).removeClass('d-none');
          $('.' + stateClass).append(new Option('Select State', '', true, true)).prop('disabled', false);
          data.states.forEach(state => {
            $('.' + stateClass).append(new Option(state.name, state.id));
          });

          $('.' + cityClass).append(new Option('Select City', '', true, true)).prop('disabled', false);
        } else {
          $('.' + stateHide).addClass('d-none');
          $('.' + cityClass).append(new Option('Select City', '', true, true)).prop('disabled', false);
          data.cities.forEach(city => {
            $('.' + cityClass).append(new Option(city.name, city.id));
          });
        }
      }
    }
  });
});

// Load Cities based on State selection
$('body').on('change', '.js-example-basic-single4', function () {
  const id = $(this).val();
  const lang = $(this).attr('data-code');
  const cityClass = lang + "_state_city_id";

  $('.' + cityClass + ' option').remove();

  $.ajax({
    type: 'POST',
    url: getCityUrl,
    data: { id, lang },
    success: function (data) {
      console.log(data);
      const defaultOption = new Option(data.length > 0 ? 'Select City' : 'No cities available', '', true, true);
      $('.' + cityClass).append(defaultOption);
      if (data.length > 0) {
        data.forEach(city => {
          $('.' + cityClass).append(new Option(city.name, city.id));
        });
      }
    }
  });
});

// Notification
function bootnotify(message, title, type) {
  $.notify({
    message,
    title,
    icon: 'fa fa-bell'
  }, {
    type,
    placement: { from: 'top', align: 'right' },
    showProgressbar: true,
    delay: 4000,
    time: 1000,
    allow_dismiss: true
  });
}

// Hotel Form Submission
$('#hotelForm').on('submit', function (e) {
  e.preventDefault();
  const canAdd = $('button[type=submit]').data('can_hotel_add');

  if (canAdd == 0) {
    bootnotify("Please buy a plan to add a Hotel", "Alert", 'warning');
    return;
  } else if (canAdd == 2) {
    $("#checkLimitModal").modal('show');
    bootnotify("Hotel limit reached or exceeded", "Alert", 'warning');
    return;
  }

  $('.request-loader').addClass('show');

  const fd = new FormData(this);
  const action = $(this).attr('action');

  // Icon Picker
  if ($(".aaa").length > 0) {
    const iconArray = [];
    $('.aaa').each(function () {
      const icon = $(this).find('i').attr('class');
      iconArray.push(icon);
    });

    fd.set('icons', iconArray.join(','));
  }

  // TinyMCE / Summernote content
  $('.form-control').each(function () {
    if ($(this).hasClass('summernote')) {
      const editorId = $(this).attr('id');
      let content = '';
      if (editorId && typeof tinyMCE !== 'undefined' && tinyMCE.get(editorId)) {
        content = tinyMCE.get(editorId).getContent();
      } else {
        content = $(this).val();
      }
      fd.set($(this).attr('name'), content);
    }
  });

  $.ajax({
    url: action,
    method: 'POST',
    data: fd,
    contentType: false,
    processData: false,
    success: function (data) {
      $('.request-loader').removeClass('show');

      if (data.limit_error || data.status === 'success' || data.status === 'error') {
        location.reload();
      }

      if (data === "downgrade") {
        $('.modal').modal('hide');
        bootnotify("Your Package limit reached or exceeded!", "Warning", 'warning');
        $("#checkLimitModal").modal('show');
      }
    },
    error: function (error) {
      let errors = `<li><p class="text-danger mb-0">An unexpected error occurred. Please try again.</p></li>`;
      if (error.responseJSON?.errors) {
        errors = Object.values(error.responseJSON.errors).map(
          err => `<li><p class="text-danger mb-0">${err[0]}</p></li>`
        ).join('');
      }

      $('#hotelErrors ul').html(errors);
      $('#hotelErrors').show();
      $('.request-loader').removeClass('show');

      $('html, body').animate({ scrollTop: $('#hotelErrors').offset().top - 100 }, 1000);
    }
  });
});

// Amenities Checkbox Update
$('body').on('click', '.input-checkbox', function () {
  const selectedValues = [];
  const code = $(this).data('code');
  const languageId = $(this).data('language_id');
  const hotelId = $(this).data('listing_id');
  const checkboxClass = code + "_input-checkbox";

  $("." + checkboxClass + ":checked").each(function () {
    selectedValues.push($(this).val());
  });

  const selectedValuesString = selectedValues.join(',');

  $.ajax({
    url: updateAminitie,
    method: 'POST',
    data: {
      aminities: selectedValuesString,
      languageId,
      hotelId
    },
    success: function (data) {
      if (data.status === 'success') {
        $('.request-loader').removeClass('show');
        location.reload();
      }
    },
    error: function () {
      bootnotify("Something went wrong!", "Warning", 'warning');
    }
  });
});

// Remove video image from DB
$(document).on('click', '.videoimagermvbtndb', function () {
  const indb = $(this).data('indb');
  $(".request-loader").addClass("show");

  $.ajax({
    url: videormvdbUrl,
    type: 'POST',
    data: { fileid: indb },
    success: function (data) {
      if (data.status === 'success') {
        $('.request-loader').removeClass('show');
        location.reload();
      }
    }
  });
});

// Image preview and remove
$('.video-img-input').on('change', function (event) {
  const file = event.target.files[0];
  const reader = new FileReader();

  reader.onload = function (e) {
    $('.uploaded-img2').attr('src', e.target.result);
    $('.remove-img2').show();
  };

  reader.readAsDataURL(file);
});

$('.remove-img2').on('click', function () {
  $('.video-img-input').val('');
  $('.uploaded-img2').attr('src', '{{ asset("assets/img/noimage.jpg") }}');
  $(this).hide();
});
