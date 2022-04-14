/**
 * 현재 프로젝트에서 hwp 컴포넌트를 사용함에 있어 공통적으로 사용되는 기능들을 만들어놓음..
 * author : bhhan
 * date : 2011.03.02
 */

var MinVersion = 0x05050111;
function InitToolBarJS(ctrlname)
{
	var bw = cmmfn_get_browserinfo(); 
	if(! bw.startsWith("IE") )
	{
		alert("인터넷 익스플로러에서만 사용가능합니다.");
		return;
	}
	
	hwpctrl = (ctrlname == undefined || ctrlname == '') ? 
			document.getElementById('HwpCtrl') : document.getElementById(ctrlname);
	
	if(_VerifyVersion(hwpctrl) == false)
		return;
	

}

function _VerifyVersion(hwpctrl)
{
	//설치 확인
	
	if(hwpctrl == null || hwpctrl.Version == null)
	{
		alert("한글이 설치되지 않았습니다.");
		//return false;
	}
	//버젼 확인
	var CurVersion = hwpctrl.Version;
	if(CurVersion < MinVersion)
	{
		alert("HwpCtrl의 버젼이 낮아서 정상적으로 동작하지 않을 수 있습니다.\n"+
			"최신 버젼으로 업데이트하기를 권장합니다.\n\n"+
			"현재 버젼:" + CurVersion.toString(16) + "\n"+
			"권장 버젼:" + MinVersion.toString(16) + " 이상"			
			);
	}
	return true;
}
