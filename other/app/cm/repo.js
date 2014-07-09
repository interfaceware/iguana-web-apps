app.cm.repo = {};

app.cm.repo.renderRow = function(Name, Src, RSrc, Type){
   var H = "<input placeholder = 'Name' class='reponame' value ='"+ Name + "'>" +
      "<input placeholder = 'Local Storage' class='reposrc' value='" + Src + "'>" +
      "<input placeholder = 'Remote Source' class='reporsrc' value = '" + RSrc + "'>" +
      "<select class='locationtype' data-selected = '"+ Type +"'>" +
         "<option value='Local'>Local</option>"+
         "<option value='GitHub-ReadOnly'>GitHub (Readonly)</option>"+
         "<option value='Default'>Interfaceware Repo</option>" + 
      "</select><span class='button delete'>Delete</span>";
   var Rtn = $('<div/>', { 'class' : 'repoEdit', 'html' : H});
   if (Type == 'GitHub-ReadOnly') {
      $(Rtn).find('.reporsrc').attr('placeholder', '/username/repository/ i.e. /interfaceware/iguana-web-apps/');
   }
   else if (Type == "Local") {
      $(Rtn).find('.reporsrc').hide();
      $(Rtn).find('.reposrc').attr('placeholder', 'Source');
   }
   else if (Type == "Default"){
      $(Rtn).find('.reporsrc').addClass('disabled').prop('disabled' , true);
   }
   $(Rtn).find('select').val($(Rtn).find('select').attr('data-selected'));
   return Rtn;
};

app.cm.repo.model = function(){
   function Pad (Str){
      Str = Str.trim();
      if ((Str.length > 0) && (Str.slice(-1) != '/')) {
         Str = Str.concat('/');
      }
      return Str;
   }
   var Data = [];
   $('.repoEdit').each(function(i, Src){ 
      Data[i] = {
         'Name': $(this).find('.reponame').val(),
         'Source':Pad($(this).find('.reposrc').val()),
         'RemoteSource':Pad($(this).find('.reporsrc').val()),
         'Type':$(this).find('.locationtype').val()
      };
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
};

app.cm.repo.onTypeChange = function (ThisParent, Type){
   var newRow = $(app.cm.repo.renderRow('', '', '', Type)).insertBefore(ThisParent);
   $(ThisParent).remove();
   if (Type == 'Default'){
      $(newRow).find('.reponame').val('Iguana Apps');
      $(newRow).find('.reposrc').val('~/iguana-web-apps/');
      $(newRow).find('.reporsrc').val('/interfaceware/iguana-web-apps/');
   }
};

PAGE.editRepo = function(Params){
   $.post("listRepo", function(D){
      console.log(D);
      var H = cm.help.header() + cm.help.breadCrumb('Edit List of repositories');
      H += "<form id='repo'> </form>";
      H += "<div id='error' hidden='true'>An essential field is blank</div>" +
         "<p><span class='button' id='add'>Add</span><p><span class='button' id='save'>Save</span>&nbsp;<span class='button' id='cancel'>Cancel</span></p>" + 
         cm.help.footer();
      $('body').html(H);

      for (var i=0; i< D.length; i++){
         $('#repo').append(app.cm.repo.renderRow(D[i].Name, D[i].Source, D[i].RemoteSource, D[i].Type));
      }
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
      $('#add').click(function(Event){
          $('form').append(app.cm.repo.renderRow('','','','Local')).children("div:last").hide().slideToggle();
      });
      $('#cancel').click(function(Event){
         document.location.hash = '#Page=viewRepo';
      });
      $('body').on("click", ".delete", function(E){
          $(this).parent('div').slideToggle(function(){ $(this).remove()});
      });
      $('body').on('change', '.locationtype', function(E){
         var Selected = $(this).find('option:selected').val();
         var ThisParent = $(this).parent();
         app.cm.repo.onTypeChange(ThisParent, Selected);
      });
      $('body').on('mouseleave', '#save', function(E){
         $('#error').delay(500).hide(100);
      });
   });
};
