var NAVTREE =
[
  [ "RTI Connext C API", "index.html", [
    [ "RTI Connext", "index.html", null ],
    [ "Modules", "modules.html", "modules" ],
    [ "Data Structures", null, [
      [ "Data Structures", "annotated.html", "annotated" ],
      [ "Data Structure Index", "classes.html", null ],
      [ "Data Fields", "functions.html", [
        [ "All", "functions.html", "functions_dup" ],
        [ "Variables", "functions_vars.html", "functions_vars" ]
      ] ]
    ] ],
    [ "Examples", "examples.html", "examples" ]
  ] ]
];

var NAVTREEINDEX =
[
"HelloWorldPlugin_8c-example.html",
"group__DDSDomainParticipantFactoryModule.html#gacd908ae7d4885fd0c064f8ef5ed4f75f",
"group__DDSDynamicDataModule.html#gafc7b66b712353340eaf29e2cffa17a33",
"group__DDSOctetsBuiltInTypeModule.html#ga272e402d04f18a2900c7cc5d94d67503",
"group__DDSReaderModule.html#ga2c2a5ee697d6c73a68196a566708abeb",
"group__DDSSubscriberModule.html#ga2755712602505786a23baef5a42d6782",
"group__DDSTypeCodeModule.html#gga0e3f0b2c88d331a730fe35e5ef75f670a3f748ca053347749870891792831e2cf",
"group__NDDSTransportUserModule.html#ga20f6bc00d0424e6a52a13fc038879d96",
"structDDS__DataReaderProtocolStatus.html#a38340ed75be0d97564657e455c3b8b70",
"structDDS__DomainParticipantConfigParams__t.html#aa8c75b0ab49766ec907c7fbd08c37444",
"structDDS__OfferedDeadlineMissedStatus.html#acd00bafe297f4563cb55f1dda96bfa4d",
"structDDS__SequenceNumber__t.html#a5a5d03c1c000db23622583d2070e4b6d",
"structNDDS__Config__LoggerDevice.html#abd8ceb605cf2cd65464cc11fac32b404"
];

var SYNCONMSG = 'click to disable panel synchronisation';
var SYNCOFFMSG = 'click to enable panel synchronisation';
var navTreeSubIndices = new Array();

function getData(varName)
{
  var i = varName.lastIndexOf('/');
  var n = i>=0 ? varName.substring(i+1) : varName;
  return eval(n.replace(/\-/g,'_'));
}

function stripPath(uri)
{
  return uri.substring(uri.lastIndexOf('/')+1);
}

function stripPath2(uri)
{
  var i = uri.lastIndexOf('/');
  var s = uri.substring(i+1);
  var m = uri.substring(0,i+1).match(/\/d\w\/d\w\w\/$/);
  return m ? uri.substring(i-6) : s;
}

function localStorageSupported()
{
  try {
    return 'localStorage' in window && window['localStorage'] !== null && window.localStorage.getItem;
  }
  catch(e) {
    return false;
  }
}


function storeLink(link)
{
  if (!$("#nav-sync").hasClass('sync') && localStorageSupported()) {
      window.localStorage.setItem('navpath',link);
  }
}

function deleteLink()
{
  if (localStorageSupported()) {
    window.localStorage.setItem('navpath','');
  } 
}

function cachedLink()
{
  if (localStorageSupported()) {
    return window.localStorage.getItem('navpath');
  } else {
    return '';
  }
}

function getScript(scriptName,func,show)
{
  var head = document.getElementsByTagName("head")[0]; 
  var script = document.createElement('script');
  script.id = scriptName;
  script.type = 'text/javascript';
  script.onload = func; 
  script.src = scriptName+'.js'; 
  if ($.browser.msie && $.browser.version<=8) { 
    // script.onload does work with older versions of IE
    script.onreadystatechange = function() {
      if (script.readyState=='complete' || script.readyState=='loaded') { 
        func(); if (show) showRoot(); 
      }
    }
  }
  head.appendChild(script); 
}

function createIndent(o,domNode,node,level)
{
  if (node.parentNode && node.parentNode.parentNode) {
    createIndent(o,domNode,node.parentNode,level+1);
  }
  var imgNode = document.createElement("img");
  imgNode.width = 16;
  imgNode.height = 22;
  if (level==0 && node.childrenData) {
    node.plus_img = imgNode;
    node.expandToggle = document.createElement("a");
    node.expandToggle.href = "javascript:void(0)";
    node.expandToggle.onclick = function() {
      if (node.expanded) {
        $(node.getChildrenUL()).slideUp("fast");
        if (node.isLast) {
          node.plus_img.src = node.relpath+"ftv2plastnode.png";
        } else {
          node.plus_img.src = node.relpath+"ftv2pnode.png";
        }
        node.expanded = false;
      } else {
        expandNode(o, node, false, false);
      }
    }
    node.expandToggle.appendChild(imgNode);
    domNode.appendChild(node.expandToggle);
  } else {
    domNode.appendChild(imgNode);
  }
  if (level==0) {
    if (node.isLast) {
      if (node.childrenData) {
        imgNode.src = node.relpath+"ftv2plastnode.png";
      } else {
        imgNode.src = node.relpath+"ftv2lastnode.png";
        domNode.appendChild(imgNode);
      }
    } else {
      if (node.childrenData) {
        imgNode.src = node.relpath+"ftv2pnode.png";
      } else {
        imgNode.src = node.relpath+"ftv2node.png";
        domNode.appendChild(imgNode);
      }
    }
  } else {
    if (node.isLast) {
      imgNode.src = node.relpath+"ftv2blank.png";
    } else {
      imgNode.src = node.relpath+"ftv2vertline.png";
    }
  }
  imgNode.border = "0";
}

function newNode(o, po, text, link, childrenData, lastNode)
{
  var node = new Object();
  node.children = Array();
  node.childrenData = childrenData;
  node.depth = po.depth + 1;
  node.relpath = po.relpath;
  node.isLast = lastNode;

  node.li = document.createElement("li");
  po.getChildrenUL().appendChild(node.li);
  node.parentNode = po;

  node.itemDiv = document.createElement("div");
  node.itemDiv.className = "item";

  node.labelSpan = document.createElement("span");
  node.labelSpan.className = "label";

  createIndent(o,node.itemDiv,node,0);
  node.itemDiv.appendChild(node.labelSpan);
  node.li.appendChild(node.itemDiv);

  var a = document.createElement("a");
  node.labelSpan.appendChild(a);
  node.label = document.createTextNode(text);
  node.expanded = false;
  a.appendChild(node.label);
  if (link) {
    var url;
    if (link.substring(0,1)=='^') {
      url = link.substring(1);
      link = url;
    } else {
      url = node.relpath+link;
    }
    a.className = stripPath(link.replace('#',':'));
    if (link.indexOf('#')!=-1) {
      var aname = '#'+link.split('#')[1];
      var srcPage = stripPath($(location).attr('pathname'));
      var targetPage = stripPath(link.split('#')[0]);
      a.href = srcPage!=targetPage ? url : '#';
      a.onclick = function(){
        storeLink(link);
        if (!$(a).parent().parent().hasClass('selected'))
        {
          $('.item').removeClass('selected');
          $('.item').removeAttr('id');
          $(a).parent().parent().addClass('selected');
          $(a).parent().parent().attr('id','selected');
        }
        var pos, anchor = $(aname), docContent = $('#doc-content');
        if (anchor.parent().attr('class')=='memItemLeft') {
          pos = anchor.parent().position().top;
        } else if (anchor.position()) {
          pos = anchor.position().top;
        }
        if (pos) {
          var dist = Math.abs(Math.min(
                     pos-docContent.offset().top,
                     docContent[0].scrollHeight-
                     docContent.height()-docContent.scrollTop()));
          docContent.animate({
            scrollTop: pos + docContent.scrollTop() - docContent.offset().top
          },Math.max(50,Math.min(500,dist)),function(){
            window.location.replace(aname);
          });
        }
      };
    } else {
      a.href = url;
      a.onclick = function() { storeLink(link); }
    }
  } else {
    if (childrenData != null) 
    {
      a.className = "nolink";
      a.href = "javascript:void(0)";
      a.onclick = node.expandToggle.onclick;
    }
  }

  node.childrenUL = null;
  node.getChildrenUL = function() {
    if (!node.childrenUL) {
      node.childrenUL = document.createElement("ul");
      node.childrenUL.className = "children_ul";
      node.childrenUL.style.display = "none";
      node.li.appendChild(node.childrenUL);
    }
    return node.childrenUL;
  };

  return node;
}

function showRoot()
{
  var headerHeight = $("#top").height();
  var footerHeight = $("#nav-path").height();
  var windowHeight = $(window).height() - headerHeight - footerHeight;
  (function (){ // retry until we can scroll to the selected item
    try {
      var navtree=$('#nav-tree');
      navtree.scrollTo('#selected',0,{offset:-windowHeight/2});
    } catch (err) {
      setTimeout(arguments.callee, 0);
    }
  })();
}

function expandNode(o, node, imm, showRoot)
{
  if (node.childrenData && !node.expanded) {
    if (typeof(node.childrenData)==='string') {
      var varName    = node.childrenData;
      getScript(node.relpath+varName,function(){
        node.childrenData = getData(varName);
        expandNode(o, node, imm, showRoot);
      }, showRoot);
    } else {
      if (!node.childrenVisited) {
        getNode(o, node);
      } if (imm || ($.browser.msie && $.browser.version>8)) { 
        // somehow slideDown jumps to the start of tree for IE9 :-(
        $(node.getChildrenUL()).show();
      } else {
        $(node.getChildrenUL()).slideDown("fast");
      }
      if (node.isLast) {
        node.plus_img.src = node.relpath+"ftv2mlastnode.png";
      } else {
        node.plus_img.src = node.relpath+"ftv2mnode.png";
      }
      node.expanded = true;
    }
  }
}

function glowEffect(n,duration)
{
  n.addClass('glow').delay(duration).queue(function(next){
    $(this).removeClass('glow');next();
  });
}

function highlightAnchor()
{
  var anchor = $($(location).attr('hash'));
  if (anchor.parent().attr('class')=='memItemLeft'){
    var rows = $('.memberdecls tr[class$="'+
               window.location.hash.substring(1)+'"]');
    glowEffect(rows.children(),300); // member without details
  } else if (anchor.parents().slice(2).prop('tagName')=='TR') {
    glowEffect(anchor.parents('div.memitem'),1000); // enum value
  } else if (anchor.parent().attr('class')=='fieldtype'){
    glowEffect(anchor.parent().parent(),1000); // struct field
  } else if (anchor.parent().is(":header")) {
    glowEffect(anchor.parent(),1000); // section header
  } else {
    glowEffect(anchor.next(),1000); // normal member
  }
}

function selectAndHighlight(hash,n)
{
  var a;
  if (hash) {
    var link=stripPath($(location).attr('pathname'))+':'+hash.substring(1);
    a=$('.item a[class$="'+link+'"]');
  }
  if (a && a.length) {
    a.parent().parent().addClass('selected');
    a.parent().parent().attr('id','selected');
    highlightAnchor();
  } else if (n) {
    $(n.itemDiv).addClass('selected');
    $(n.itemDiv).attr('id','selected');
  }
  showRoot();
}

function showNode(o, node, index, hash)
{
  if (node && node.childrenData) {
    if (typeof(node.childrenData)==='string') {
      var varName    = node.childrenData;
      getScript(node.relpath+varName,function(){
        node.childrenData = getData(varName);
        showNode(o,node,index,hash);
      },true);
    } else {
      if (!node.childrenVisited) {
        getNode(o, node);
      }
      $(node.getChildrenUL()).show();
      if (node.isLast) {
        node.plus_img.src = node.relpath+"ftv2mlastnode.png";
      } else {
        node.plus_img.src = node.relpath+"ftv2mnode.png";
      }
      node.expanded = true;
      var n = node.children[o.breadcrumbs[index]];
      if (index+1<o.breadcrumbs.length) {
        showNode(o,n,index+1,hash);
      } else {
        if (typeof(n.childrenData)==='string') {
          var varName = n.childrenData;
          getScript(n.relpath+varName,function(){
            n.childrenData = getData(varName);
            node.expanded=false;
            showNode(o,node,index,hash); // retry with child node expanded
          },true);
        } else {
          var rootBase = stripPath(o.toroot.replace(/\..+$/, ''));
          if (rootBase=="index" || rootBase=="pages") {
            expandNode(o, n, true, true);
          }
          selectAndHighlight(hash,n);
        }
      }
    }
  } else {
    selectAndHighlight(hash);
  }
}

function getNode(o, po)
{
  po.childrenVisited = true;
  var l = po.childrenData.length-1;
  for (var i in po.childrenData) {
    var nodeData = po.childrenData[i];
    po.children[i] = newNode(o, po, nodeData[0], nodeData[1], nodeData[2],
      i==l);
  }
}

function gotoNode(o,subIndex,root,hash,relpath)
{
  var nti = navTreeSubIndices[subIndex][root+hash];
  o.breadcrumbs = $.extend(true, [], nti ? nti : navTreeSubIndices[subIndex][root]);
  if (!o.breadcrumbs && root!=NAVTREE[0][1]) { // fallback: show index
    navTo(o,NAVTREE[0][1],"",relpath);
    $('.item').removeClass('selected');
    $('.item').removeAttr('id');
  }
  if (o.breadcrumbs) {
    o.breadcrumbs.unshift(0); // add 0 for root node
    showNode(o, o.node, 0, hash);
  }
}

function navTo(o,root,hash,relpath)
{
  var link = cachedLink();
  if (link) {
    var parts = link.split('#');
    root = parts[0];
    if (parts.length>1) hash = '#'+parts[1];
    else hash='';
  }
  if (root==NAVTREE[0][1]) {
    $('#nav-sync').css('top','30px');
  } else {
    $('#nav-sync').css('top','5px');
  }
  if (hash.match(/^#l\d+$/)) {
    var anchor=$('a[name='+hash.substring(1)+']');
    glowEffect(anchor.parent(),1000); // line number
    hash=''; // strip line number anchors
    //root=root.replace(/_source\./,'.'); // source link to doc link
  }
  var url=root+hash;
  var i=-1;
  while (NAVTREEINDEX[i+1]<=url) i++;
  if (navTreeSubIndices[i]) {
    gotoNode(o,i,root,hash,relpath)
  } else {
    getScript(relpath+'navtreeindex'+i,function(){
      navTreeSubIndices[i] = eval('NAVTREEINDEX'+i);
      if (navTreeSubIndices[i]) {
        gotoNode(o,i,root,hash,relpath);
      }
    },true);
  }
}

function showSyncOff(n,relpath)
{
    n.html('<img src="'+relpath+'sync_off.png" title="'+SYNCOFFMSG+'"/>');
}

function showSyncOn(n,relpath)
{
    n.html('<img src="'+relpath+'sync_on.png"/ title="'+SYNCONMSG+'">');
}

function toggleSyncButton(relpath)
{
  var navSync = $('#nav-sync');
  if (navSync.hasClass('sync')) {
    navSync.removeClass('sync');
    showSyncOff(navSync,relpath);
    storeLink(stripPath2($(location).attr('pathname'))+$(location).attr('hash'));
  } else {
    navSync.addClass('sync');
    showSyncOn(navSync,relpath);
    deleteLink();
  }
}

function initNavTree(toroot,relpath)
{
  var o = new Object();
  o.toroot = toroot;
  o.node = new Object();
  o.node.li = document.getElementById("nav-tree-contents");
  o.node.childrenData = NAVTREE;
  o.node.children = new Array();
  o.node.childrenUL = document.createElement("ul");
  o.node.getChildrenUL = function() { return o.node.childrenUL; };
  o.node.li.appendChild(o.node.childrenUL);
  o.node.depth = 0;
  o.node.relpath = relpath;
  o.node.expanded = false;
  o.node.isLast = true;
  o.node.plus_img = document.createElement("img");
  o.node.plus_img.src = relpath+"ftv2pnode.png";
  o.node.plus_img.width = 16;
  o.node.plus_img.height = 22;

  if (localStorageSupported()) {
    var navSync = $('#nav-sync');
    if (cachedLink()) {
      showSyncOff(navSync,relpath);
      navSync.removeClass('sync');
    } else {
      showSyncOn(navSync,relpath);
    }
    navSync.click(function(){ toggleSyncButton(relpath); });
  }

  navTo(o,toroot,window.location.hash,relpath);

  $(window).bind('hashchange', function(){
     if (window.location.hash && window.location.hash.length>1){
       var a;
       if ($(location).attr('hash')){
         var clslink=stripPath($(location).attr('pathname'))+':'+
                               $(location).attr('hash').substring(1);
         a=$('.item a[class$="'+clslink+'"]');
       }
       if (a==null || !$(a).parent().parent().hasClass('selected')){
         $('.item').removeClass('selected');
         $('.item').removeAttr('id');
       }
       var link=stripPath2($(location).attr('pathname'));
       navTo(o,link,$(location).attr('hash'),relpath);
     }
  })

  $(window).load(showRoot);
}

