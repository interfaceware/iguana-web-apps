app.cm.repo = {};

app.cm.repo.render = function(RepoList){
   var H = ''; 
   for (var i=0; i< RepoList.length; i++){
      H+=app.cm.repo.renderRow(RepoList[i].Name, RepoList[i].Dir);
   }
   return H;
};

app.cm.repo.renderRow = function(Name, Addr){
   return "<div class='repoEdit'><input placeholder = 'Name' type = 'edit' class='reponame' value ='"+ Name +"'><input placeholder = 'Location' type='edit' class='repodir' value='" + Addr + "'><span class='button' id='delete'>Delete</span></div>";
};

app.cm.repo.model = function(){
   var Data = [];
   $('.repoEdit').each(function(i, Dir){ 
      Data[i] = {
         'Name': $(this).find('.reponame').val(),
         'Dir':$(this).find('.repodir').val()
      };
      console.log(Data[i]);
   });
   return Data;
};

app.cm.repo.fillSelect = function(RepoList){
   var H = '<select class="repolist">';
   for (var i=0; i < RepoList.length; i++){
      if (i === cm.settings.repository ){
         H+= "<option selected>";
      } else {
         H+= "<option>";
      }
      H+= RepoList[i].Name + '-' + RepoList[i].Dir + "</option>"; 
   }
   H+= '</select>';
   $('body').on("change",".repolist", function(E){
      cm.settings.repository = $(".repolist")[0].selectedIndex;
      console.log("Changed repo index to " + cm.settings.repository);
   });
   return H;
};     

PAGE.viewRepo = function(Params){
   $.post("listRepo",
   function(D){
      console.log(D);
      var H = cm.help.header() + cm.help.breadCrumb('List of repositories');
      H+= "<div>"; 
      H+= "<a href='#Page=editRepo'><span class='button' id='edit'>Edit</span></a>";
      var RepoList = D;
      for (var i=0; i< RepoList.length; i++){
         if (D[i].name != ""){
            D[i].name += " : ";
         }
         H+="<div>" + D[i].Name + D[i].Dir + "</div>";
      }
      H += "</div>" + cm.help.footer();
      $('body').html(H);       
   });
}

PAGE.editRepo = function(Params){
   $.post("listRepo",
   function(D){
      console.log(D);
      var H = cm.help.header() + cm.help.breadCrumb('Edit List of repositories');
      H+= "<form id='repo'>";
      H+= app.cm.repo.render(D);
      H += "</form>";
      H += "<p><span class='button' id='add'>Add</span><p><span class='button' id='save'>Save</span>&nbsp;<span class='button' id='cancel'>Cancel</span></p>" + cm.help.footer();
      $('body').html(H);
      $('#save').click(function(Event){
         var Data = app.cm.repo.model();
         console.log(Data);
         $.post('saveRepo', JSON.stringify(Data), function(D){
            document.location.hash = '#Page=viewRepo';
         });         
      });
      $('#add').click(function(Event){
         Data = app.cm.repo.model();
         Data[Data.length] = '';
          $('form').append(app.cm.repo.renderRow('','')).children("div:last").hide().slideToggle();
      });
      $('#cancel').click(function(Event){
         document.location.hash = '#Page=viewRepo';
      });
      $('body').on("click", "#delete", function(E){
          $(this).parent('div').slideToggle(function(){ $(this).remove()});
      });
   });
}
