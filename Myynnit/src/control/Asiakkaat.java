package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Myynti;
import model.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		String pathInfo = request.getPathInfo();
		System.out.println("polku: "+pathInfo);
		String hakusana = pathInfo.replace("/", "");
		Dao dao = new Dao();
		ArrayList<Myynti> asiakkaat = dao.listaaKaikki(hakusana);
		System.out.println(asiakkaat);	
		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request); //Muutetaan kutsun mukana tuleva json-string json-objektiksi			
		Myynti myynti = new Myynti();
		myynti.setAsiakas_id(jsonObj.getInt("asiakas_id"));
		myynti.setEtunimi(jsonObj.getString("etunimi"));
		myynti.setSukunimi(jsonObj.getString("sukunimi"));
		myynti.setPuhelin(jsonObj.getString("puhelin"));
		myynti.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.lisaaMyynti(myynti)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  //Asiakkaan lis‰‰minen onnistui {"response":1}
		}else{
			out.println("{\"response\":0}");  //Asiakkaan lis‰‰minen ep‰onnistui {"response":0}
		}		
	}

	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
	}

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");	
		String pathInfo = request.getPathInfo();	//haetaan kutsun polkutiedot, esim. /asiakas_id		
		System.out.println("polku: "+pathInfo);
		String poistettavaAsiakas_id = pathInfo.replace("/", "");		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.poistaMyynti(poistettavaAsiakas_id)){ //metodi palauttaa true/false
			out.println("{\"response\":1}");  //Asiakkaan poistaminen onnistui {"response":1}
		}else{
			out.println("{\"response\":0}");  //Asiakkaan poistaminen ep‰onnistui {"response":0}
		}	
	}

}
