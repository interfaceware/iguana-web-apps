
/** @license
* Copyright (c) 2010-2014 iNTERFACEWARE Inc.  All rights reserved.
*/

/**
* @constructor
*/
function Tree22(Label, Class, Callbacks, Parent, Package) {
   this.m_Label = Label;
   this.m_Package = Package;
   this.m_Class = Class;
   this.m_Parent = Parent;
   this.m_Callbacks = Callbacks;
   this.m_Children = [];
   this.m_IsOpen = false;
   this.m_IsWaiting = false;
   this.m_DomNode = null;
};

Tree22.prototype = {
   label : function() {
      return this.m_Label;
  },
   add : function(Label, Class, Callbacks, Package){
      var NewChild = new Tree22(Label, Class, Callbacks, this, Package);
      this.m_Children.push(NewChild);
      return NewChild;
   },
   setCallbacks : function(Callbacks) {
      this.m_Callbacks = Callbacks;
      return this;
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
   getValue : function(Key) {
      if (this.m_Package[Key] && this.m_Package[Key] != undefined) {
         return this.m_Package[Key];
      }
      return false;
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
   render : function(Control, Owner) {
      var Node = this.makeNode(Owner);
      var List = document.createElement("ul");
      $(List).addClass('tree22').append(Node);
      Control.html(List);
      return this;
   },
   makeNode : function(Owner) {
      console.log(this);
      var Class = 'nodeText';
      if (this.m_Class) {
         Class += ' ' + this.m_Class; 
      }
      var InnerSpan = '<span class="' + Class + '">' + this.m_Label + '</span>';
      var Node = document.createElement('li');
      this.m_DomNode = Node;
      if (this.isBranch()) { 
         $(Node).addClass("branch");
         if (this.isOpen()){
            $(Node).addClass("open");
         }
         InnerSpan += ' <span class="context_click">[+]</span>';
      } else {
         $(Node).addClass('leaf');
         InnerSpan += ' <span class="context"><img src="/js/treeview/images/arrow-contracted.gif" /></span>';
      }
      $(Node).html('<div><span class="treeIcon"></span>' + InnerSpan + '</div>');


      if (this.size() > 0){
         $(Node).append("<span class='content'><ul></ul></span>");
         var SubList = $(Node).contents("span.content").children("ul");
         for (var i=0; i < this.size(); i++){
            $(SubList).append(this.child(i).makeNode(Owner));
         }
      }
      var Self = this;
      Self.ref.node = $('<input/>', {type : 'checkbox', class : 'selectfile', checked : 'true'}).prependTo($(Node));
      if (Self.m_Callbacks.Click) {
         $(Node).children('div').click(function(Event) {
            Event.stopPropagation();
            Self.m_Callbacks.Click.call(Owner, Self);
         });     
      }
      if (Self.m_Callbacks.Context) {
         var HotSpot = $(Node).find('span.context');
         HotSpot.bind('mouseenter', function(Event) {
            Event.stopPropagation();
            Self.m_Callbacks.Context.call(Owner, Self, HotSpot);
         });
      }
      if (Self.m_Callbacks.ContextClick) {
         var Button = $(Node).find('span.context_click').first();
         Button.bind('click', function(Event) {
            Event.stopPropagation();
            Self.m_Callbacks.ContextClick.call(Owner, Self, Button);
         });
      }
      return Node;
   },
   setLeaf: function() {
      this.m_Children = null;
      return this;
   }
}
   
