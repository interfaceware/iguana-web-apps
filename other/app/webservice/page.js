$(document).ready(function($) {
   console.log('Load page handling framework');
   lib.page.init(webservice.page);
   lib.ajax.errorFunc = webservice.help.showError;
});

if (webservice === undefined) { var webservice = {}; }

webservice.page = {}
   
PAGE = webservice.page;
   
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

   // lib.ajax.call('setHelp', Data, function(D){});

// HACK FOR DEVELOPMENT
var Tree2;

webservice.state = {}

webservice.onBrowseTreeClick = function(Node){
   if (!Node.m_Children.length) {
      //Returns the full node path
      var Call = Node.m_Label;
      while (Node.m_Parent.m_Parent !== null) {
         Call = Node.m_Parent.m_Label + "." + Call;
         Node = Node.m_Parent;
      }
      webservice.state.call = Call;
      // Makes the Ajax call
      lib.ajax.call('helpdata?call=' + Call, function(D){
         console.log(D);
         for (var key in D){
            /* Key 1 = No function exists
               Key 2 = No help for function exists
               Key 3 = Help data returned
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
                  //Applies classes to decorate code
                  $('#helpdata').find('pre').addClass('prettyprint lang-lua editable'); 
                  prettyPrint();
               }); 
            }
            else {
               $('#helpdata').html(webservice.help.header() + "<p>" + D[key] + "</p>" + webservice.help.footer());
            }
         }
      });
   }
   else{
      Node.toggle();
   }
}

PAGE.browse = function(Params) {
   lib.ajax.call('helpsummary', function(D){
      console.log(D);
      $('body').html("<div id='browser'></div><div id='helpdata'></div>");
      $.each(D, function(key,value){
         console.log(value);
         Tree2 = new Tree22(key, "tree");
         myRender(value, Tree2);
      });
      Tree2.render($("#browser"));
      Tree2.setOnClick(webservice.onBrowseTreeClick);
      Tree2.open();
   });
}

PAGE.default = PAGE.browse
   
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
