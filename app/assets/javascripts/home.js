$(function(){
	$('form input[type="submit"]').attr("disabled", true);
	$(document).ajaxStart(function() {
	  $(".overlay-body").addClass('overlay');  
	  $(".loader").show();
	}).ajaxStop(function() {
	  $(".overlay-body").removeClass('overlay');
	  $(".loader").hide();
	});

	$('form').on('change', '#car_model_fipe_id', function(){
		var car_model_years_id = $('#car_model_years_id');
		$('#car_model_year_fipe_id').attr("disabled", true);
		$.ajax({
			type: 'GET',
			url: '/home/search_model_years',
			dataType: 'json',
			data: {
				car_mark_fipe_id: $("#car_mark_fipe_id option:selected").val(),
				car_model_fipe_id: $(this).val()
			},
			success: function(data){
				$("#car_model_year_fipe_id").remove();
				createSelect('car_model_year_fipe_id', 'car_model_year[fipe_id]', data.object, 'Selecione um Ano/Modelo', car_model_years_id);
				$('form input[type="submit"]').attr("disabled", false);
			}
		});
	});
	$('form').on('change', '#car_mark_fipe_id', function(){
		var car_models_id = $("#car_models_id");
		$('#car_model_fipe_id').attr("disabled", true);
		$('#car_model_year_fipe_id').attr("disabled", true);
		$.ajax({
			type: 'GET',
			url: '/home/search_models',
			dataType: 'json',
			data: {fipe_id: $(this).val()},
			success: function(data){
				$('#car_model_fipe_id').remove();
				createSelect('car_model_fipe_id', 'car_model[fipe_id]', data.object, 'Selecione um Modelo', car_models_id);
			}
		});
	});
	var createSelect = function(id, name, data, text, object){
		var select = document.createElement('select');
		var option = document.createElement('option');
		select.id = id;
		select.name = name;
		option.value = '';
		option.text = text;
		select.add(option, 0);
		$.each(data, function(i, el){
			option = document.createElement('option');
			option.text = el.name;
			option.value = el.id;
			select.appendChild(option);
		});		
		object.append(select);
		document.getElementById(id).classList.add('form-control')
	}	
})