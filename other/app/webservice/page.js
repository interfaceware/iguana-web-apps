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

webservice.state = {}

function renderdatapage (Call){
   lib.ajax.call('helpdata?call=' + Call, function(D){
   console.log(D);
   for (var key in D){
      /* Key 1 = No function exists
         Key 2 = No help for function exists
         Key 3 = Help data returned
      */
      /* Currently, I coded it so that if no help for a function exists, it returns Key 3 with an empty JSON table .
         However, since the helpsummary tree is built from a list of functions, the function is guranteed to exist
         when called by helpdata, making Key 1 redundant. We may end up removing this whole Key system in the end.
      */
      if (key == 3) {
         $('#helpdata').html(lib.help.render(D[key], Call));
         $('#helpdata').ready(function(){
            //Creates the help button
            $('#helpdata').find('h1').first().before(
               $('<button/>', {
                  class: 'Edit',
                  text: 'Edit',
                  onClick: 'lib.help.togglemode(this)'
            }));
            //Applies the google-prettify to the appropriate fields (Usage and Examples)
            $('#helpdata').find('pre').addClass('prettyprint lang-lua editable'); 
            prettyPrint();
         }); 
      }
      else {
         //Returns error message (Currently it is impossible to get to this branch of the conditional statement unless
         //the user decides to type in the URL directly.
         $('#helpdata').html(webservice.help.header() + "<p>" + D[key] + "</p>" + webservice.help.footer());
      }
   }});
}


webservice.onBrowseTreeClick = function(Node){
   //If the node clicked is a leaf and not a branch
   if (!Node.m_Children.length) {
      //Returns the full path of the function
      var Call = Node.m_Label;
      while (Node.m_Parent.m_Parent !== null) {
         Call = Node.m_Parent.m_Label + "." + Call;
         Node = Node.m_Parent;
      }
      webservice.state.call = Call;
      // Makes the Ajax call
      renderdatapage(Call);
   }
   //If the node clicked is a branch
   else{
      Node.toggle();
   }
}

PAGE.browse = function(Params) {
   lib.ajax.call('helpsummary', function(D){
      console.log(D);
      $('body').html("<div id='browser'></div><div id='helpdata'></div>");
      
      var Tree2 = new Tree22('highrise', "tree");
      myRender(D, Tree2);
      Tree2.render($("#browser"));
      Tree2.setOnClick(webservice.onBrowseTreeClick);
      Tree2.open();
   });
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
