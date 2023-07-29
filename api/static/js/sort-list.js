// Taken from https://code-boxx.com/drag-drop-sortable-list-javascript/

function slist (target, onUpdateMethod=null) {
    // (A) GET LIST + ATTACH CSS CLASS
    target = document.getElementById(target);
    target.classList.add("slist");
  
    // (B) MAKE ITEMS DRAGGABLE + SORTABLE
    var items = target.getElementsByTagName("li"), current = null;
    for (let i of items) {
      // (B1) ATTACH DRAGGABLE
      i.draggable = true;
      
      // (B2) DRAG START - YELLOW HIGHLIGHT DROPZONES
      i.addEventListener("dragstart", function (ev) {
        current = this;
        for (let it of items) {
          if (it != current) { it.classList.add("hint"); }
        }
      });
      
      // (B3) DRAG ENTER - RED HIGHLIGHT DROPZONE
      i.addEventListener("dragenter", function (ev) {
        if (this != current) { this.classList.add("active"); }
      });
  
      // (B4) DRAG LEAVE - REMOVE RED HIGHLIGHT
      i.addEventListener("dragleave", function () {
        this.classList.remove("active");
      });
  
      // (B5) DRAG END - REMOVE ALL HIGHLIGHTS
      i.addEventListener("dragend", function () {
        for (let it of items) {
          it.classList.remove("hint");
          it.classList.remove("active");
        }
      });
   
      // (B6) DRAG OVER - PREVENT THE DEFAULT "DROP", SO WE CAN DO OUR OWN
      i.addEventListener("dragover", function (evt) {
        evt.preventDefault();
      });
   
      // (B7) ON DROP - DO SOMETHING
      i.addEventListener("drop", function (evt) {
        evt.preventDefault();
        if (this != current) {
          let currentpos = 0, droppedpos = 0;
          for (let it=0; it<items.length; it++) {
            if (current == items[it]) { currentpos = it; }
            if (this == items[it]) { droppedpos = it; }
          }
          if (currentpos < droppedpos) {
            this.parentNode.insertBefore(current, this.nextSibling);
          } else {
            this.parentNode.insertBefore(current, this);
          }
        }
        if (onUpdateMethod != null){
          onUpdateMethod();
        }
      });
    }
  }