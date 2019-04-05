function fireThisUponEvent() {
	$('.leapyear-algorithmic').persianDatepicker({
		inline: true,
		onSelect: function(unix){
			console.log(unix);
			$.get("/calendar/day/"+ unix, function(data){

				$('#date-view').html(data);
			}, "html");

			console.log('datepicker select : ' + unix);
		}
	});
};

function EpochToDate(epoch) {
    if (epoch < 10000000000)
        epoch *= 1000; // convert to milliseconds (Epoch is usually expressed in seconds, but Javascript uses Milliseconds)
    var epoch = epoch + (new Date().getTimezoneOffset() * -1); //for timeZone
    return new Date(epoch);
}

$(document).on('turbolinks:load', fireThisUponEvent)
