<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>
<form id="tiedot">
	<table>
	<thead>
		<tr>
			<th colspan="6" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
		</tr>
		<tr>
			<th>Asiakas_id</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><input type="text" name="asiakas_id" id="asiakas_id"></td>
			<td><input type="text" name="etunimi" id="etunimi"></td>
			<td><input type="text" name="sukunimi" id="sukunimi"></td>
			<td><input type="text" name="puhelin" id="puhelin"></td>
			<td><input type="text" name="sposti" id="sposti"></td> 
			<td><input type="submit" id="tallenna" value="Hyväksy"></td>
		</tr>
	</tbody>
</table>
<input type="hidden" name="vanhaasiakas_id" id="vanhaasiakas_id">
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	//Haetaan muutettavan asiakkaan tiedot. Kutsutaan backin GET-metodia ja välitetään kutsun mukana muutettavan tiedon id
	//GET /asiakkaat/haeyksi/asiakas_id
	var asiakas_id = requestURLParam("asiakas_id"); //Funktio löytyy scripts/main.js 	
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){	
		$("#vanhaasiakas_id").val(result.asiakas_id);		
		$("#asiakas_id").val(result.asiakas_id);	
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);		
		$("#sposti").val(result.sposti);	
    }});
	
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true,				
				minlength: 2				
			},	
			sukunimi:  {
				required: true,				
				minlength: 2				
			},
			puhelin:  {
				required: true,
				minlength: 5
			},	
			sposti:  {
				required: true,
				email: true				
			}	
		},
		messages: {
			etunimi: {     
				required: "Puuttuu",				
				minlength: "Liian lyhyt"			
			},
			sukunimi: {
				required: "Puuttuu",				
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				email: "Ei kelpaa"
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	});  
});
//funktio tietojen päivittämistä varten. Kutsutaan backin PUT-metodia ja välitetään kutsun mukana uudet tiedot json-stringinä.
//PUT /asiakkaat/
function paivitaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
    $("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
  }else if(result.response==1){			
     $("#ilmo").html("Asiakkaan päivittäminen onnistui.");
     $("#etunimi, #sukunimi, #puhelin, #sposti").val("");
		}
    }});	
}
</script>
</html>