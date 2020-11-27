<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib prefix="jstl" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="security"	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>


<link rel="stylesheet" href="styles/canv.css" type="text/css">


<body style= "background-image: url('images/fondo5.jpg');">

<div style="margin-left:50px">
<button onclick="nodeList()" class="dropbtn" style="margin: 0% auto 0% auto; font-weight: bold; width: 6%; height: 35px; padding: 5px; background-color: #3544f0;color: white; font-family: Arial, Helvetica, sans-serif;"><spring:message code="canvas.nodes" /></button>
<input type="text" id="nodeSelected" readonly >

<div id="ListOfNodes" class="dropdown-content">
<input 
  type="radio" name="node" 
  id="kpi" class="input-hidden" onclick="valueNode(this.value)" value="Kpi"/>
<label for="kpi">
  <img id="Kpi" src="images/kpi.png"/>
</label>

<input 
  type="radio" name="node"
  id="kri" class="input-hidden" onclick="valueNode(this.value)" value="Kri"/>
<label for="kri">
  <img id="Kri" src="images/kri.png"/>
</label>

<input 
  type="radio" name="node" 
  id="measure" class="input-hidden" onclick="valueNode(this.value)" value="Measure"/>
<label for="measure">
  <img id="Measure" src="images/measure.png" />
</label>

<input 
  type="radio" name="node"
  id="goal" class="input-hidden" onclick="valueNode(this.value)" value="Goal"/>
<label for="goal">
  <img id="Goal" src="images/goal.png"/>
</label>

<input 
  type="radio" name="node" 
  id="process" class="input-hidden" onclick="valueNode(this.value)" value="Process" />
<label for="process">
  <img id="Process" src="images/process.png"/>
</label>

<input 
  type="radio" name="node"
  id="process with Inputs" class="input-hidden" onclick="valueNode(this.value)" value="Process with Inputs"/>
<label for="process with Inputs">
  <img id="Process with Inputs" src="images/processWI.png"/>
</label>
</div>



<a style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; margin-left:20px;" ><spring:message code="canvas.edges" /></a><select id="selEdge" style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; margin-left:5px;" >
 			<option style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; " selected="selected" value="none">---</option>
 			<option style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: red;"  value="red"><spring:message code="canvas.edge.red" /></option>
            <option style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: black;" value="black"><spring:message code="canvas.edge.black" /></option>
            <option style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: #9DBB61;" value="green"><spring:message code="canvas.edge.green" /></option>
            <option style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: gray;" value="gray"><spring:message code="canvas.edge.gray" /></option>
            <option style="font-weight: bold; font-family: Arial, Helvetica, sans-serif; color: blue;" value="blue"><spring:message code="canvas.edge.blue" /></option>
          </select>  
<button onclick="javascript:clearArea();return false;" style="margin: 0% auto 0% auto; margin-left: 25px; font-weight: bold; width: 10%; height: 35px; padding: 5px; background-color: #1dc1de; color: white; font-family: Arial, Helvetica, sans-serif;"><spring:message code="canvas.clear" /></button> 
         
<a id="btn_getimg"><spring:message code="canvas.export" /></a>


<a style="font-weight: bold; font-family: Arial, Helvetica, sans-serif;" ><spring:message code="canvas.format" /></a> <select id="selFormat">
            <option value=".jpg"selected="selected">JPG</option>
            <option value=".png">PNG</option>
            <option value=".bmp">BMP</option>
            <option value=".gif">GIF</option>
          </select> 
         
         
</div>  
<canvas id="cnv1" width="1150" height="527"></canvas>

<script>


function nodeList() {
  document.getElementById("ListOfNodes").classList.toggle("show");
}


window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
    }
  }
}
  

var cnv_id = 'cnv1';


function drawArrowCnv(cnv_id){

  var allow_draw =-1;  

  var cnv = document.getElementById(cnv_id);  
  var cnv0 = {};  
  var ctx = cnv.getContext('2d');  
  var x, y = 0;  
  var clicks =0;  
  var last_clk = [0, 0]; 
  var nra =0;  

 
  this.allowDraw = function(){ allow_draw *=-1; }

  
  this.letDraw = function(){ return allow_draw; }

  
  function cloneCanvas(cnv){
    cnv.insertAdjacentHTML('afterend', '<canvas id="cnv0_cnv" style="'+ cnv.getAttribute('style') +'" width="'+ cnv.width +'" height="'+ cnv.height +'"></canvas>');
    
    var cnv0 = document.getElementById('cnv0_cnv');
    var cnt = cnv0.getContext('2d');

    
    cnv0.width = cnv.width;
    cnv0.height = cnv.height;
    cnv0.style.display ='none';

    
    cnt.drawImage(cnv, 0, 0);
    return cnv0;
  }

  
  this.restoreCanvas = function(){
    cnv0.style.display ='block';  
    cnv.outerHTML ='';  
    cnv0.id = cnv_id;  
    drawAr = new drawArrowCnv(cnv_id);  
    if(drawAr.letDraw() ==-1 && allow_draw ==1) drawAr.allowDraw();  
  }

  
  function getXYpos(elm){
    x = elm.offsetLeft;  
    y = elm.offsetTop;  

    elm = elm.offsetParent;  

   
    while(elm != null) {
      x = parseInt(x) + parseInt(elm.offsetLeft);
      y = parseInt(y) + parseInt(elm.offsetTop);
      elm = elm.offsetParent;
    }

    
    return {'x':x, 'y':y};
  }

  
  function getCoords(e){
    var xy_pos = getXYpos(e.target);

    
    if(navigator.appVersion.indexOf('MSIE') !=-1) {
      
      var standardBody = (document.compatMode =='CSS1Compat') ? document.documentElement : document.body;

      x = event.clientX + standardBody.scrollLeft;
      y = event.clientY + standardBody.scrollTop;
    }
    else {
      x = e.pageX;
      y = e.pageY;
    }
    return [x - xy_pos['x'], y - xy_pos['y']];
  }

  
  function Line(x1,y1,x2,y2){
    this.x1=x1;
    this.y1=y1;
    this.x2=x2;
    this.y2=y2;
  }
  
  Line.prototype.addArrowhead = function(ctx,w){
    
    var v = document.getElementById("selEdge").value;
    var c; 
    var g;

  if (!w){
	  

    if (v == "red"){
       c = "#C05046";
    }else if (v == "black"){
       c = "#000000";
    }else if (v == "green"){
       c = "#9DBB61";
    }else if (v == "gray"){
       c = "#595959";
    }else if (v == "blue"){
       c = "#1F477D";
    }else if (v == "none"){
    	c = "#FFFFFF"
        }
  }else{
	  c = "#FFFFFF"
	  }

    if (v == "black"){
       g = 1;
    }else if (v == "red"){
       g = 2;
    }else {
       g = 1.5;
    }

    
    
    
 
    ctx.strokeStyle = c;
    ctx.fillStyle = c;
    ctx.lineWidth = g;

    
    var v = document.getElementById("selEdge").value;
    var d1;
    var d2;
    
    if (v == "red" || v == "black"){
       d1 = 0;
       d2 = 0;
    }else if (v == "gray" || v == "green"){
       d1 = 12;
       d2 = 6
    }else {
       d1 = 4;
       d2 = 3;
    }
    
    ctx.beginPath();
    ctx.setLineDash([d1,d2]); 
    ctx.moveTo(this.x1,this.y1);
    ctx.lineTo(this.x2,this.y2);
    ctx.stroke();

    
    var endRadians = Math.atan((this.y2-this.y1)/(this.x2-this.x1));
    endRadians += ((this.x2>=this.x1)?90:-90)*Math.PI/180;
    this.drawArrowhead(ctx,this.x2,this.y2,endRadians);
  }
  
  Line.prototype.drawArrowhead = function(ctx,x,y,radians){
  
  var v = document.getElementById("selEdge").value;
  var p;
  
  if (v == "blue"){
       p = 0;
     }else{
       p = 6;
    }
  
   
   ctx.save();
   ctx.beginPath();
   ctx.translate(x,y);
   ctx.rotate(radians);
   ctx.moveTo(0,0);
   ctx.lineTo(p /2,12);
   ctx.lineTo(-p /2,12);
   ctx.closePath();
   ctx.restore();
   ctx.fill();
 }

  
  function drawArrow(e){
    
    if(allow_draw ==1){
      var coords = getCoords(e);
      nra++;
      if(nra ==1) cnv0 = cloneCanvas(cnv);  

      

      if (clicks != 1) clicks++;
      else {
        
        if (last_clk[0]>80 && last_clk[0]<1070 && coords[0]>80 && coords[0]<1070 && last_clk[1]>60 && last_clk[1]<467 && coords[1]>60 && coords[1]<467){
          
          var w = false;

		 if(last_clk[0] == coords[0] && last_clk[1] == coords[1]){
			w =true;
		 }
            
          var line = new Line(last_clk[0],last_clk[1],coords[0],coords[1]);
          line.addArrowhead(ctx,w);  

          clicks = 0;  
        }

        
      }

      last_clk = [coords[0],coords[1]];  
    }
  };

  
  cnv.addEventListener('click', drawArrow, false);
}

function valueNode(val) {
  document.getElementById("nodeSelected").value = val;
}

function node(cnv_id){
var cnv = document.getElementById(cnv_id); 
var ctx = cnv.getContext('2d');  

cnv.addEventListener("dblclick", function(e){
   getPosition(e); 
});


  function getPosition(event){
      var rect = cnv.getBoundingClientRect();
      var pass = false;
      var x = event.clientX - rect.left;
      var y = event.clientY - rect.top;
      
      if (x>80 && x<1070 && y>60 && y<467){
        pass = true;
      }

      drawCoordinates(x,y,pass);
  }

  function drawCoordinates(x,y,pass){	

    var v = document.getElementById("nodeSelected").value;

    
      var img;
    
    if (v == "Kpi"){
      img = document.getElementById("Kpi");
    }else if (v == "Kri"){
      img = document.getElementById("Kri");
    }else if (v == "Measure"){
      img = document.getElementById("Measure");
    }else if (v == "Goal"){
      img = document.getElementById("Goal");
    }else if (v == "Process"){
      img = document.getElementById("Process");
    }else if (v == "Process with Inputs"){
      img = document.getElementById("Process with Inputs");
    }
    
    var w = img.naturalWidth;
    var h = img.naturalHeight;

    if(pass){
      ctx.drawImage(img, x-(w/2), y-(h/2));
    }
    
       

  }


}


function clearArea() {
  
    var canvas = document.getElementById("cnv1");
    var ctx = canvas.getContext("2d");
    ctx.setTransform(1, 0, 0, 1, 0, 0);
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
}






var drawAr =0;

if(document.getElementById(cnv_id)){
  drawAr = new drawArrowCnv(cnv_id);
  node(cnv_id);
  drawAr.allowDraw();
} 




var btn_getimg = document.getElementById('btn_getimg');

btn_getimg.addEventListener('click', function() {

  var f = document.getElementById("selFormat").value;
  this.href = document.getElementById(cnv_id).toDataURL();  
  this.download ='canvas_'+ cnv_id + f;  
});

</script>


 
<br> 


</body>
<br>

<tag:back code="actor.back" url="welcome/index.do" />
