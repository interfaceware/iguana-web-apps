var assets = {
   // The delete pictures are implemented by floating it to the right of each table line. 
   // There is probaly a much better way of implementing it. Also, each button can be a div tag
   // instead of an image tag if that makes it easier to style.
   'del':
        $('<img/>', 
      {  
         class: 'cross',
         src: 'lib/tree/images/folder-open.gif',
         onclick: 'var table = $(this).parents("tbody"); $(this).parent().remove(); if (table.parents("div").hasClass("helpReturns")){renumber(table);}' 
      })
   ,
   'newobj':{
      'parameter' : $('<tr/>',
      { html: '<td class="editable b" contenteditable="true"></td><td class="editable" contenteditable="true"></td><td><input type="checkbox"></td>', }),
      'returns' : $('<tr/>',
      { html: '<td/><td contenteditable="true"></td>'}),
      'seealso' : $('<li/>',
      { html: '<input type="text" class="linkLabel" placeholder="Link label"><input type="text" class="linkAdd" placeholder="Link address"><img src="lib/tree/images/folder-open.gif" onclick="$(this).parent().remove()"></img>'})
   },
   'add':{
      'parameter' : $('<img/>',
      {
         class: 'add',
         src: 'lib/tree/images/folder-open.gif',
         onclick: 'var table = $(this).siblings("table").find("tbody"); table.append(assets.newobj.parameter.clone()); table.children(":last").append(assets.del.clone())'
      }),
      'returns' : $('<img/>',
      {
         class: 'add',
         src: 'lib/tree/images/folder-open.gif',
         onclick: 'var table = $(this).siblings("table").find("tbody"); table.append(assets.newobj.returns.clone()); table.children(":last").append(assets.del.clone()); renumber(table)'
      }),
      'seealso' :  $('<img/>',
      {
         class: 'add',
         src: 'lib/tree/images/folder-open.gif',
         onclick: '$(this).siblings("ol").append(assets.newobj.seealso.clone())'
      })
   }
};
