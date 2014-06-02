$(document).ready(function($) {
   console.log('Load page handling framework');
   lib.page.init(webservice.page);
   lib.ajax.errorFunc = webservice.help.showError;
});

if (webservice === undefined) { var webservice = {}; }

webservice.page = {}
   
PAGE = webservice.page;
   
PAGE.default = function(Params) {
   $('body').html(webservice.help.header() + "Hello world!" + webservice.help.footer());
}
   
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

// HACK FOR DEVELOPMENT
var Tree2;

 var Edit  = $('<button/>', 
      {
         class: 'Edit',
         text: 'Edit',
         click: ChangeFormat()
      });

webservice.onBrowseTreeClick = function(Node){
   if (!Node.m_Children.length) {
      console.log(Node);
      var Call = Node.m_Label;
      while (Node.m_Parent.m_Parent !== null) {
         Call = Node.m_Parent.m_Label + "." + Call;
         Node = Node.m_Parent;
         console.log(Call);
      }
      lib.ajax.call('helpdata?call=' + Call, function(D){
         for (var key in D){
            console.log(key);
            if (key == 3) {
               $('#helpdata').html(lib.help.render(D[key]));
               $('#helpdata').ready(function(){
                  $('#helpdata').find('h1').first().before(Edit);
                  $('#helpdata').find('pre').addClass('prettyprint'); 
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
      Tree2 = new Tree22("List of Functions", "tree");
      myRender(D, Tree2);
      Tree2.render($("#browser"));
      Tree2.setOnClick(webservice.onBrowseTreeClick);
      Tree2.open();
   });
}

function ChangeFormat() {
}

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
