var Callback = {
   'Click' : {
      'call': onClick
   }};

function DisplayData(Pane, Data, FileType, Overwrite){
   if (FileType=="img"){
      $('<img/>', {'src' : Data}).appendTo(Pane);
   }
   else if (FileType == "str"){
      if (Overwrite) {
         $('<pre/>', { 'html' : Data}).appendTo(Pane);
      }else {
         $('<pre/>', { 'html' : Data}).appendTo(Pane);
      }
   };
}

function implement3Way(Data){
   $('<select/>', {
      'class' : 'leftselect',
      'html' : '<option value="foss" selected>Fossil</option>' +
      '<option value="trans">Translator Milestone</option>'}
    ).prependTo('.leftpane');
   $('<select/>', {
      'class' : 'rightselect',
      'html' : '<option value="trans">Translator Milestone</option>' +
      '<option value="old" selected>Export Directory</option>'}
    ).prependTo('.rightpane');
   var DiffText = diffString(Data.foss, Data.old);
   $('.leftpane > pre').html(DiffText);
   $('.rightpane > pre').html(DiffText);
   $('.body').on('change', 'select', function(){
      if ($(this).hasClass('leftselect')){
         var DiffText = diffString(Data[$(this).val()], Data[$('.rightpane > select').val()]);
         $(this).siblings('pre').html(DiffText);
         $('.rightpane > pre').html(DiffText);
      }
      else {
         var DiffText = diffString(Data[$(this).val()], Data[$('.leftpane > select').val()]);
         $(this).siblings('pre').html(DiffText);
         $('.leftpane > pre').html(DiffText);
      }});
}

function resetDivs(){
   $('.leftpane').html('').css({'float' : '', 'width': ''});
   $('.rightpane').html('').css({'float' : '', 'width': ''});
   $('select').remove();
}

function onClick(Owner, Self){
   if (Self.isBranch()){
      console.log(Self);
      Self.toggle();
      return;}
   console.log(Self);
   console.log(Self.ref);
   $('.diffpane').data(Self.ref);
   resetDivs();
   var IsImg = (Self.ref.type == "img");
   var Diff = Self.ref.diff;
   if (Diff == 100) {
      var Data = Self.ref.foss;
      if (Self.ref.type == "str") {Data = Self.ref.foss.replace(/</g, "&lt;");}
      DisplayData('.leftpane', Data, Self.ref.type, true);
   }
   else if (Diff == 123){
      implement3Way(Self.ref);
   }
   else{
      var DiffText = "";
      if (Diff == 112){
         DiffText = diffString(Self.ref.foss, Self.ref.old);
         DisplayData('.rightpane', DiffText, Self.ref.type);
      }
      else if (Diff == 122){
         DiffText = diffString(Self.ref.foss, Self.ref.trans);
         DisplayData('.rightpane', DiffText, Self.ref.type);
      }
      else if (Diff == 121){
         DiffText = diffString(Self.ref.foss, Self.ref.trabs);
         DisplayData('.rightpane', DiffText, Self.ref.type);
      }
      DisplayData('.leftpane', DiffText, Self.ref.type, true);
      $('.leftpane').css({'width':'48%', 'float':'left'});
      $('.rightpane').css({'width':'48%', 'float':'right'});
   }
}
