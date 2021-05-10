$(document).on('ready turbolinks:load', () => {
  hideForms();
  modalScript();

  if ($('#diability-input-field').val() == "") {
    $('#medical-services-question').removeClass("d-none");
    $('#disability-input').addClass("d-none");

    if ($('#medical-input').val() == "") {
      $('#check-no').prop('checked', true);
      $('#check-yes').prop('checked', false);
      $('#medical-services-question').addClass("d-none");
    } else{
      $('#check-no').prop('checked', false);
      $('#check-yes').prop('checked', true);
      $('#medical-services').removeClass("d-none");
    }
  } else {
    $('#medical-services-question').addClass("d-none");
    $('#disability-input').removeClass("d-none");
  }
});

window.hideForms = function() {
  $('input[type="radio"]').click(function(){
    var inputValue = $(this).attr("value");

    if (inputValue == 'yes'){
      $('#medical-services-question').addClass("d-none");
      $('#disability-input').removeClass("d-none");
    } else{
      $('#medical-services-question').removeClass("d-none");
      $('#medical-services').addClass("d-none");
      $('#disability-input').addClass("d-none");
      $('#diability-input-field').val("");
    }
  });

  $('input[type="checkbox"]').click(function(){
    var inputValue = $(this).attr("value");

    if (inputValue == 'yes'){
      $('#check-no').prop('checked', false);
      $('#medical-services').removeClass("d-none");
    } else{
      $('#check-yes').prop('checked', false);
      $("#medical-input").val("");
      $('#medical-services').addClass("d-none");
    }
  });
}

window.modalScript = function() {
  $('#popup').click(function() {
    event.preventDefault();
    $('#myModal').modal('show');
  });
}
