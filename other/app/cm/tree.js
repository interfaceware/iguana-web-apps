
/** @license
 * Copyright (c) 2010-2014 iNTERFACEWARE Inc.  All rights reserved.
 */


function Tree22(Label, Class, Parent) {
   this.m_Label = Label;
   this.m_Class = Class;
   this.m_Parent = Parent || null; 
   this.m_Children = [];
   this.m_IsOpen = false;
   this.m_IsWaiting = false;
   this.m_DomNode = null;
   this.m_OnClick = null;
};

Tree22.prototype = {
   projectTree : function() {
      return $("#SCRcontents");
   },
   label : function() {
      return this.m_Label;
   },
   add : function(Label, Class){
      var C = new Tree22(Label, Class, this);
      this.m_Children.push(C);
      return C;
   },
   size : function() {
      if (! this.isBranch()) {
         return 0;
      }
      return this.m_Children.length;
   },
   child : function(i) {
      return this.m_Children[i]; 
   },
   parent : function() {
      return this.m_Parent;
   },

   parents : function() {
      var Prnts = [];
      var One = this.parent();
      while (One.parent()) {
         Prnts.push(One);
         One = One.parent();
      }
      return Prnts.reverse();
   },
   toggle : function() {
      if (!this.isBranch()){ 
         return; 
      }
      if (this.isOpen()){
         this.close();
      } else {
         this.open(); 
      }
   },
   close : function() {
      this.m_IsOpen = false;
      $(this.m_DomNode).removeClass('open');
      return this;
   },
   open : function() {
      this.m_IsOpen = true;
      $(this.m_DomNode).addClass('open');
      return this;
   },
   wait : function() {
      this.m_IsWaiting = true;
      $(this.m_DomNode).find("span.nodeText").addClass('waiting');
      return this;
   },
   endWait : function() {
      this.m_IsWaiting = false;
      $(this.m_DomNode).find("span.nodeText").removeClass('waiting');
      return this;
   },
   isOpen : function() {
      return this.m_IsOpen;
   },
   isWaiting : function() {
      return this.m_IsWaiting;
   },
   isBranch : function() {
      return this.m_Children.length > 0;
   },
   render : function(Control) {
      var Node = this.makeNode();
      var List = document.createElement("ul");
      $(List).addClass('tree22').append(Node);
      Control.html(List);
      return this;
   },
   makeNode : function() {
      var Node = document.createElement('li');
      this.m_DomNode = Node;
      if (this.isBranch()) { 
         $(Node).addClass("branch");
         if (this.isOpen()){
            $(Node).addClass("open");
         }
      } else {
         $(Node).addClass('leaf');
      }
      var Class = 'nodeText';
      if (this.m_Class) { Class += ' ' + this.m_Class; }
      $(Node).html('<div><span class="treeIcon"></span><span class="' + Class + '">' + this.m_Label + "</span></div>");
      if (this.size() > 0){
         $(Node).append("<span class='content'><ul></ul></div>");
         var SubList = $(Node).contents("span.content").children("ul");
         for (var i=0; i < this.size(); i++){
            $(SubList).append(this.child(i).makeNode());
         }
      }
      var Self = this;
      Self.reference.node = $('<input/>', {type : 'checkbox', class : 'selectfile', checked : 'true'}).prependTo($(Node));
      $(Node).children('div').click(function() {
         if (Self.isBranch()){
            Self.toggle();
         }
         else {
            console.log(Self);
            var path = Self.label();
            var Parent = Self;
            while (Parent.parent() && Parent.parent().parent()){
               Parent = Parent.parent();
               path = Parent.label() + '/' + path;
            };
            console.log(path);
            console.log(Self.reference);
            $('.diffpane').data(Self.reference);
            if (Self.reference.status == "diff") {
               var difftext = diffString(Self.reference.newdata.replace(/</g, "&lt;"), Self.reference.olddata.replace(/</g, "&lt;"));
               $('.leftpane > pre').html(difftext);
               $('.rightpane > pre').html(difftext);
            }
            else {
               $('.leftpane > pre').text(Self.reference.newdata.replace(/</g, "&lt;"));
               $('.rightpane > pre').text('');
            }}
      });
      $(Node).children('.selectfile').click(function(){
         if ($(this).is(':checked')){
            $(this).parent().find('.selectfile').prop('checked', true);
         }
         else {
            $(this).parent().find('.selectfile').prop('checked', false);
         }
      });
      return Node;
   },
   setLeaf: function() {
      this.m_Children = null;
      return this;
   },
   enrichLeaf: function(Payload) {
      for (var Key in Payload) {
         var Self = this;
         (function (ThisKey, ThisVal) {
            Self.__defineGetter__("get_" + ThisKey, function() {
               return ThisVal;
            });
         })(Key, Payload[Key]);
      }
      return this;
   },
   setOnClick: function(OnClickCallback){
      this.m_OnClick = OnClickCallback;
   }
}
