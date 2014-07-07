var Callback = {
   'Click' : {
      'call': onClick
   }};
function DisplayData(Pane, Data, FileType, Extention){
   if (FileType=="img"){
      $('<img/>', {'src' : 'data:image/'+ Extention +';base64,' + Data}).appendTo(Pane);
   }
   else if (FileType == "str"){
      $('<pre/>', { 'html' : Data, 'class' : 'code' }).appendTo(Pane);
   };
};

function Display2Data(Left, Right, FileType, Extention){   
   if (FileType == "img"){
      $('<img/>', {'src' : 'data:image/'+ Extention +';base64,' + Left}).appendTo('.leftpane');
      $('<img/>', {'src' : 'data:image/'+ Extention +';base64,' + Right}).appendTo('.rightpane');
   }
   else if (FileType == "str"){
      DiffText = diffString(Left, Right);
      $('<pre/>', { 'html' : DiffText, 'class' : 'code' }).appendTo('.leftpane');
      $('<pre/>', { 'html' : DiffText, 'class' : 'code' }).appendTo('.rightpane');
   }
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
      '<option value="repo" selected>Export Directory</option>'}
    ).prependTo('.rightpane');
   Display2Data(Data.foss, Data.repo, Data.type, Data.extention);
   $('div.diffpane').on('change', 'select', function(){
      $('.diffpane pre').remove(); 
      if ($(this).hasClass('leftselect')){
         Display2Data(Data[$(this).val()], Data[$('.rightpane > select').val()], Data.type, Data.Extention);
      }
      else {
         Display2Data(Data[$('.leftpane > select').val()], Data[$(this).val()], Data.type, Data.Extention);
      }
   });
   $('.leftpane').css({'width':'48%', 'float':'left'});
   $('.rightpane').css({'width':'48%', 'float':'right'});
   styleCode();
}

function resetDivs(){
   $('.leftpane').html('').css({'float' : '', 'width': ''});
   $('.rightpane').html('').css({'float' : '', 'width': ''});
   $('select').remove();
}

function styleCode(){
   $('.leftpane').find('ins, del').addClass('new');
   $('.rightpane').find('ins, del').addClass('old');
}

function appendHeaders(Left, Right){
   if (Left) {
      $('<div/>', { 'class' : 'DiffHeading', 'text' : Left}).prependTo('.leftpane');
   }
   if (Right) {
      $('<div/>', { 'class' : 'DiffHeading', 'text' : Right}).prependTo('.rightpane');
   }
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
   var Left, Right;
   var Diff = Self.ref.diff;
   var LeftText, RightText;   
   if (Diff == 100 || Diff == 110) {
      var Data = Self.ref.foss;
      if (Self.ref.type == "str") {Data = Self.ref.foss.replace(/</g, "&lt;");}
      DisplayData('.leftpane', Data, Self.ref.type, Self.ref.extention);
      LeftText = (Diff == 100) ? 'Fossil' : 'Fossil, Translator';
   }
   else if (Diff == 123){
      implement3Way(Self.ref);
   }
   else{
      var DiffText = "";
      if (Diff == 112){
         Left = Self.ref.foss;
         Right = Self.ref.repo;
         LeftText = 'Fossil, Translator';
         RightText = 'Repo Data';
      }
      else if (Diff == 122){
         Left = Self.ref.foss;
         Right = Self.ref.trans;
         LeftText = 'Fossil';
         RightText = 'Translator, Repo Data';
      }
      else if (Diff == 121){
         Left = Self.ref.foss;
         Right = Self.ref.trans;
         LeftText = 'Fossil, Repo Data';
         RightText = 'Translator';
      }
      else if (Diff == 120){
         Left = Self.ref.foss;
         Right = Self.ref.trans;
         LeftText = 'Fossil';
         RightText = 'Translator';
      }
      else if (Diff == 12){
         Left = Self.ref.trans;
         Right = Self.ref.repo;
         LeftText = "Translator";
         RightText = "Repo";
      }
      console.log(Self.ref);
      Display2Data(Left, Right, Self.ref.type, Self.ref.extention);
      $('.leftpane').css({'width':'48%', 'float':'left'});
      $('.rightpane').css({'width':'48%', 'float':'right'});
   }
   styleCode();
   appendHeaders(LeftText, RightText);
}
