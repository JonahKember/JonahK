$(function()
{	

	$("#btnSecret").click(function()
	{

		var answer1 = /^Curtis Friesen$/;
		var answer2 = /^1996-10-09$/;
		var answer3 = /^Bloomsburg$/i;

		if(answer1.test($("#input1").val()) && answer2.test($("#input2").val()) && answer3.test($("#input3").val()))
		{
			$(".continue").html("<a href='name.html'>CONTINUE</a>");			
		}
		else
		{
			alert("Please Try Again.");
			location.reload();
		}
		
	});	

	$("#halloffame").click(function()
	{
		var input1 = $("#secretName").val();

		if(input1 == "")
		{
			alert("Please enter a name.");
		}
		else 
		{
			$.get("js/secret.php", {secretName:input1}, function(halloffame)
			{
				$("#secret").replaceWith(halloffame);
			});
		}

	});	
});

	



