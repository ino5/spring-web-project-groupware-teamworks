<!DOCTYPE html> <html> <head> <title>Drag and Drop Table Columns</title>
<script type="text/javascript">
window.onload = function() {
    var head = document.getElementsByTagName("th");
    for (i=0; i<head.length; i++) {
        head[i].onselectstart = function() { return false }
        head[i].onmousedown = mousedown;
        head[i].onmouseover = mouseover;
        head[i].onmouseout = mouseout;
        head[i].onmouseup   = mouseup;
        head[i].className = "tableHead";
    }

}

function mousedown(ev){
    dragTD = this;
    addClass(this, "dragging");
}

function mouseover(ev){
    if (dragTD === null) { return;}
    addClass(this, "hovering");
}

function mouseout(ev){
    if (dragTD === null) { return;}
    removeClass(this, "hovering");
}

function mouseup(ev){
    removeClass(this, "hovering");
    removeClass(dragTD, "dragging");
    dragTD = null;
}

function addClass(src, classname) {
    if (src.className.indexOf(classname) === -1 ) {
        src.className += " " + classname;
    }
}

function removeClass(src, classname) {
    src.className = src.className.replace(" " + classname, "");
}
function mouseup(ev){
    removeClass(this, "hovering");
    removeClass(dragTD, "dragging");
   
    var srcInx = dragTD.cellIndex;
    var tarInx = this.cellIndex;
    var table = document.getElementById("tableOne");
    var rows = table.rows;
   
    for (var x=0; x<rows.length; x++) {
        tds = rows[x].cells;
        rows[x].insertBefore(tds[srcInx], tds[tarInx])
    }
   
    dragTD = null;
}

</script> <style> table { font-size: 11px; border-collapse:collapse; border:1px solid } table td, table th { border:1px solid; padding: 3px; } .dragging { background:#eee; color:#000 } .hovering { background:#ccc; color:#555 } </style> <script> // just mouse actions window.onload = function() { var head = document.getElementsByTagName("th"); for (i=0; i<head.length; i++) { head[i].onselectstart = function() { return false } head[i].onmousedown = mousedown; head[i].onmouseover = mouseover; head[i].onmouseout = mouseout; head[i].onmouseup = mouseup; } } var dragTD = null; function mousedown(ev){ dragTD = this; this.className = "dragging" } function mouseover(ev){ if (dragTD === null) { return;} this.className = "hovering" } function mouseout(ev){ if (dragTD === null) { return;} this.className = "" } function mouseup(ev){ this.className = "" dragTD.className = "" dragTD = null; } </script> </head> <body> <table id="tableOne"> <thead> <tr> <th>Column 1</th> <th>Column 2</th> <th>Column 3</th> <th>Column 4</th> <th>Column 5</th> <th>Column 6</th> <th>Column 7</th> <th>Column 8</th> <th>Column 9</th> <th>Column 10</th> </tr> </thead> <tbody> <tr> <td>data 1</td> <td>data 2</td> <td>data 3</td> <td>data 4</td> <td>data 5</td> <td>data 6</td> <td>data 7</td> <td>data 8</td> <td>data 9</td> <td>data 10</td> </tr> <tr> <td>data 1</td> <td>data 2</td> <td>data 3</td> <td>data 4</td> <td>data 5</td> <td>data 6</td> <td>data 7</td> <td>data 8</td> <td>data 9</td> <td>data 10</td> </tr> </tbody> </table> </body> </html>
