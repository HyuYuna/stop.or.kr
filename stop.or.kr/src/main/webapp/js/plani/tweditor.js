//#tip create editor
if(true)
{
	var clsid =  "976A7D6C-B14C-4e50-A5C3-B43D8C49D8C8";
	var version = "3,7,1,1014";
	var cab = "/tagfree/tweditor.cab";
	var env = "/tagfree/env.xml";
	var id = "twe";
	var applyinitdata = 1;//apply:1
	var editmode = 0;//edit:0
	
	//실서버용
	var key = "V0A2uaQso0/8AXA8MdsVoOJVvykinUJZ9fotn/eb/6r3HYnBFLAoHE8o4ryw4XvsvVpHAvmZeQvWrJx1aNWDBKV/cA0HSe9pZBspWWkapbXN0etEq1/lI0IqI7xNlIPxmr8HoQs7eBRM++bxVkNHI273YNoDdn+aheLDtCDpDaJJsXvNof2A1rKvQ6LEVFje";
	
	//개발서버용
	//var key = "rK7Zm5P+LSHfubsKavCS2VbAbgJeD8oFqUUdJ/nbw0p2r1aksszLEfzx0Gj2gcbJbbPHUSWeUPScws18rp9Dk+e+7RjvRiTIgF7jo5Cq2n041gea6vPfKx8KmYcmVYv0Gq+7WIWX4/06xDsHBxZCothdkzNM9IHUMrfjAgDNH/M=";
	
	document.write('<object ID="'+id+'" width="100%" height="100%" CLASSID="CLSID:'+clsid+'" CODEBASE="'+cab+'#version='+version+'">');
	document.write('<PARAM name="InitFile" value="'+env+'"/>');
	document.write('<PARAM name="ApplyInitData" VALUE="'+applyinitdata+'"/>');
	document.write('<PARAM name="Mode" VALUE="'+editmode+'"/>');
	document.write('<PARAM name="LicenseKey" value="'+key+'">');
	document.write('</object>');
}

//#tip p->br, br->p
if(false)
{
	document.write('<script language="JScript" FOR="'+id+'" EVENT="OnKeyDown(event)">');
	document.write('	if (!event.shiftKey && event.keyCode == 13)');
	document.write('	{');
	document.write('		document.'+id+'.InsertHtml("<br>");');
	document.write('		event.returnValue = true;');
	document.write('	}');
	document.write('	if (event.shiftKey && event.keyCode == 13)');
	document.write('	{');
	document.write('		document.'+id+'.InsertHtml("<p>");');
	document.write('		event.returnValue = true;');
	document.write('	}');
	document.write('</script>');
}

//#tip protected backspace
if(false)
{
	document.write('<script language="JavaScript">');
	document.write('document.onkeydown = twekeyhandler;');
	document.write('function twekeyhandler() {');
	document.write('    if (window.event && window.event.keyCode == 8) {');
	document.write('        alert("protected backspace key");');
	document.write('        return false;');
	document.write('    }');
	document.write('}');
	document.write('</script>');
}

//#tip activex redesign ref)http://www.tagfree.com/ver2/Support_Center/faq/faq_view.asp?supno=11
if(false)
{
	if(editmode != 1)
	{
		document.write('<script language="JScript" FOR="'+id+'" EVENT="BeforeTabChange">');
		document.write('	var view = document.'+id+'.ActiveTab;');
		document.write('	if(view == 1 || view == 3)');
		document.write('	{')
		document.write('		document.'+id+'.ObjectToScript("object", "object.asp","tag","tweobject");');
		document.write('		document.'+id+'.ObjectToScript("embed", "object.asp","tag","tweobject");');
		document.write('	}')
		document.write('</script>');
		document.write('<script language="JScript" FOR="'+id+'" EVENT="OnLoadComplete">');
 		document.write('	var view = document.'+id+'.ActiveTab;');
 		document.write('	if(view == 1 || view == 3) document.'+id+'.ScriptToObject("tag","tweobject");');
		document.write('</script>');
	}
}

//#tip custom popup menu
if(false)
{
	document.write('<OBJECT id="ContextMenu" width="0" height="0" classid="CLSID:7823A620-9DD9-11CF-A662-00AA00C066D2" CODEBASE="http://activex.microsoft.com/controls/iexplorer/x86/iemenu.cab#version=4"></OBJECT>');
	document.write('<script language="JScript" FOR="twe" EVENT="OnContextMenu(event)">');
	document.write('	ContextMenu.Clear();');
	document.write('	ContextMenu.AddItem ("1", 1);');
	document.write('	ContextMenu.AddItem ("2", 2);');
	document.write('	ContextMenu.PopUp();');
	document.write('	event.returnValue = true;');
	document.write('</script>');
	document.write('<SCRIPT LANGUAGE="VBscript">');
	document.write('Sub ContextMenu_Click(ByVal x)');
	document.write('	alert(x)');
	document.write('End Sub');
	document.write('</SCRIPT>');
}