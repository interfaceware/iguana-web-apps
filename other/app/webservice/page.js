$(document).ready(function($) {
   console.log('Load page handling framework');
   lib.page.init(webservice.page);
   lib.ajax.errorFunc = webservice.help.showError;
});

if (webservice === undefined) { var webservice = {}; }

webservice.page = {}
   
PAGE = webservice.page;
// This code may never be executed, but I'm not certain because it was here before I wrote my code
// If it is till used, the CSS has been changed so the header and footer will not display properly.
PAGE.functionHelp = function(Params){
   if (Params.call === undefined){
      webservice.help.showError("Please supply call &lt;function name&gt;")
      return;
   }
   lib.ajax.call('helpdata?call=' + Params.call, function(D){
      var H = webservice.help.header() + lib.help.render(D) + webservice.help.footer();
      $('body').html(H);
   });
}
   
PAGE.editHelp = function(P){
   webservice.initBrowseTree();
   $('#helpdata').html("Edit " + P.path);  
   var Call = P.path;
   lib.ajax.call('helpdata?call=' + Call, function(D){
      console.log(D);
      var H = lib.help.render.edit(D,Call) + '<span class="edit">Save</span>';
      console.log(H);
      $('#helpdata').html(H);
      $('.editable').attr('contenteditable', 'true');
      
      $('.edit').click(function(E){
         var D = lib.help.savedata();
         console.log(D);
      });
   });
}
   
PAGE.viewHelp = function(P){
   console.log('View Help');
   console.log(P);
   webservice.initBrowseTree();
   var Call = P.path;
   // TODO swap over to jQuery standard
   lib.ajax.call('helpdata?call=' + Call, function(D){
      console.log(D);
      var H = lib.help.render.all(D,Call);// + "<a href='#Page=editHelp&path=" + Call + "'><span class='edit'>Edit</span></a>";
      console.log(H);
      $('#helpdata').html(H);
      //Applies the google-prettify to the appropriate fields (Usage and Examples)
      $('#helpdata').find('pre').addClass('prettyprint lang-lua editable'); 
      prettyPrint(); // called in the prettify library.
   });
}

webservice.onBrowseTreeClick = function(Node){
   //If the node clicked is a leaf and not a branch
   if (!Node.m_Children.length) { //Returns the full path of the function
      var Call = Node.m_Label;
      while (Node.m_Parent.m_Parent !== null) {
         Call = Node.m_Parent.m_Label + "/" + Call;
         Node = Node.m_Parent;
      }
      document.location.hash = '#Page=viewHelp&path=' + Call;
   } else {   //If the node clicked is a branch
      Node.toggle();
   }
}
   
webservice.initBrowseTree = function(){
   if (null === document.getElementById('browser')){
      $('body').html("<div id='browser'></div><div id='helpdata'></div>");  
      // TODO - use standard jQuery
      lib.ajax.call('helpsummary', function(D){
         console.log(D);      
         var Tree2 = new Tree22('highrise', "tree");
         // TODO myRender should be in a nsmespace - probably only need to expand the first node and we probably
         // should select the first function in the tree etc.
         myRender(D, Tree2);
         Tree2.render($("#browser"));
         Tree2.setOnClick(webservice.onBrowseTreeClick);
         Tree2.open();
      });
   } else {
      console.log("Browse tree initialized");
   }
}

PAGE.browse = function(Params) {
   webservice.initBrowseTree();
}

PAGE.default = PAGE.browse

// This function can be put into page.js as a method of the Tree22 object   
function myRender(D, tree){
  $.each(D, function(key, value){
   if (!tree.IsOpen){
      tree.open();
      }
   if(typeof value == "object"){
      myRender(value, tree.add(key, "tree"));
   }
   else {
      tree.add(key, "tree");
   };
})};
