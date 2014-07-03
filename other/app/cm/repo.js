app.cm.repo = {};

app.cm.repo.render = function(RepoList){
   var H = ''; 
   for (var i=0; i< RepoList.length; i++){
      H+=app.cm.repo.renderRow(RepoList[i].Name, RepoList[i].Source, RepoList[i].RemoteSource, RepoList[i].Type);
   }
   return H;
};

app.cm.repo.renderRow = function(Name, Src, RSrc, Type){
   var rtn = "<div class='repoEdit ' ><input placeholder = 'Name' class='reponame' value ='"+ Name +
       "'><input placeholder = 'Source' class='reposrc' value='" + Src + "'><input placeholder = 'Remote Source' class='reporsrc'";
   if (RSrc == "") {
      rtn += " hidden='true' ";
   }
   rtn += " value = '" + RSrc + "'><select class='locationtype' data-selected = '"+Type+
      "'><option value='Local'>Local</option><option value='GitHub-ReadOnly'>GitHub (Readonly)</option><option value='IguanaServer'>Iguana</option>" + 
      "</select><span class='button delete'>Delete</span></div>";
   return rtn;
};

app.cm.repo.model = function(){
   var Data = [];
   $('.repoEdit').each(function(i, Src){ 
      Data[i] = {
         'Name': $(this).find('.reponame').val(),
         'Source':$(this).find('.reposrc').val(),
         'RemoteSource':$(this).find('.reporsrc').val(),
         'Type':$(this).find('.locationtype').val()
      };
      console.log(Data[i]);
      //If either all the required fields are filled or empty, continue. Else return false.
      if (!((Data[i].Name == "") == (Data[i].Source == ""))){
         Data = false;
         return false;
      }
      console.log(Data[i]);
   });
   return Data;
};

app.cm.repo.fillSelect = function(RepoList){
   var H = '<select class="repolist">';
   var D = RepoList;
   for (var i=0; i < RepoList.length; i++){
      if (i === cm.settings.repository ){
         H+= "<option selected>";
      } else {
         H+= "<option>";
      }
      D[i].Name = '<b>' + D[i].Name + '</b>' + " : ";
      if (D[i].Type != ''){
         if (D[i].Type == 'GitHub-ReadOnly'){
            D[i].Type = 'GitHub (Readonly)';
         }
         D[i].Type += ' -- ';
      }
      if (D[i].RemoteSource != ''){
         D[i].Source += " <i>retrieved from:</i> ";
      }
      H+= D[i].Name + D[i].Type + D[i].Source + D[i].RemoteSource + "</option>"; 
   }
   H+= '</select>';
   $('body').on("change",".repolist", function(E){
      cm.settings.repository = $(".repolist")[0].selectedIndex;
      console.log("Changed repo index to " + cm.settings.repository);
   });
   return H;
};     

PAGE.viewRepo = function(Params){
   $.post("listRepo", function(D){
      console.log(D);
      var H = cm.help.header() + cm.help.breadCrumb('List of repositories');
      /*if (!D) {
         H+="<div>Your Config file is currently empty. Click <span class='button setdefault'>here</span> to setup a default repository</div>";
         H+=cm.help.footer();
         $('body').html
         $('body').on('click', '.setdefault', function(){
            $.post('saveRepo', JSON.stringify([{'Name' = 'Default', 'Source' =  */
      H+= "<div>"; 
      H+= "<a href='#Page=editRepo'><span class='button' id='edit'>Edit</span></a>";
      var RepoList = D;
      for (var i=0; i< RepoList.length; i++){
         D[i].Name = '<b>' + D[i].Name + '</b>' + " : ";
         if (D[i].Type != ''){
            D[i].Type += ' -- ';
         }
         if (D[i].RemoteSource != ''){
            D[i].Source += " <i>retrieved from:</i> ";
         }
         H+="<div>" + D[i].Name + D[i].Type + D[i].Source + D[i].RemoteSource + "</div>";
      }
      H += "</div>" + cm.help.footer();
      $('body').html(H);       
   });
}

PAGE.editRepo = function(Params){
   $.post("listRepo", function(D){
      console.log(D);
      var H = cm.help.header() + cm.help.breadCrumb('Edit List of repositories');
      H+= "<form id='repo'>";
      H+= app.cm.repo.render(D);
      H += "</form>";
      H += "<div id='error' hidden='true'>An essential field is blank</div><p><span class='button' id='add'>Add</span><p><span class='button' id='save'>Save</span>&nbsp;<span class='button' id='cancel'>Cancel</span></p>" + cm.help.footer();
      $('body').html(H);
      $('#save').click(function(Event){
         var Data = app.cm.repo.model();
         console.log(Data);
         if (!Data){
            $('#error').show();
            return false;
         }
         $.post('saveRepo', JSON.stringify(Data), function(D){
            document.location.hash = '#Page=viewRepo';
         });         
      });
      // Selects the correct drop down item
      $('.locationtype').each(function(key, val){
         $(this).val($(this).attr('data-selected'));
      });
      $('#add').click(function(Event){
         //Data = app.cm.repo.model();
         //Data[Data.length] = '';
          $('form').append(app.cm.repo.renderRow('','','','')).children("div:last").hide().slideToggle();
      });
      $('#cancel').click(function(Event){
         document.location.hash = '#Page=viewRepo';
      });
      $('body').on("click", ".delete", function(E){
          $(this).parent('div').slideToggle(function(){ $(this).remove()});
      });
      $('body').on('change', '.locationtype', function(E){
         var selected = $(this).find('option:selected').text();
         if (selected == 'GitHub (Readonly)') {
            $(this).prev().show();
         }
         else if (selected == 'Local'){
            $(this).prev().hide();
            $(this).prev().val('');
         }       
      });
      $('body').on('mouseleave', '#save', function(E){
         $('#error').delay(500).hide(100);
      });
   });
}
   
