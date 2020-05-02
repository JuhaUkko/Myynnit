<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
<style>
.oikealle{
	text-align: right;
}
</style>
</head>
<body>
<table id="listaus" border>
	<thead>	
		<tr>
			<th colspan="7" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th class="oikealle" colspan="2">Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana" ></th> <!-- colspan kertoo tässä hakusarakkeiden määrän -->
			<th><input type="button" value="hae" id="hakunappi"></th>
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
	</tbody>
</table>
<script>
$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaasiakas.jsp";
	});

	haeAsiakkaat();
	$("#hakunappi").click(function(){		
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeAsiakkaat();
		  }
	});
	$("#hakusana").focus();//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
});	

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_"+field.asiakas_id+"'>"; // 'rivi_"+field.asiakas_id+"' tarvittiin, jotta poistettavan rivin asiakas saadaan värjättyä punaiseksi, ks. alla
        	htmlStr+="<td>"+field.asiakas_id+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";  
        	htmlStr+="<td>"+field.sposti+"</td>"; 
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+")>Poista</span></td>"; // hipsut ' ja ' laitetaan, jos String eli '"+field.asiakas_id+"'
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}
function poista(asiakas_id){
	if(confirm("Poista asiakas " + asiakas_id +"?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + asiakas_id +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
</script>
</body>
</html>