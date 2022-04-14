/* 비밀번호 작성규칙
	[개인정보 안전성확보조치에 관한 고시]
		일반적으로 비밀번호의 최소 길이는 그 비밀번호를 구성하는 문자의 종류에 따라 
		최소 10자리 또는 8자리 이상의 길이로 구성하여야 한다.
		 ∙ 최소 10자리 이상 : 영대문자(A~Z, 26개), 영소문자(a~z, 26개), 숫자(0~9, 10개) 및 특수문자(32개) 중 2종류 이상으로 구성한 경우
		 ∙ 최소 8자리 이상 : 영대문자(A~Z, 26개), 영소문자(a~z, 26개), 숫자(0~9, 10개) 및 특수문자(32개) 중 3종류 이상으로 구성한 경우
	
		그리고 추측하기 어려운 비밀번호를 생성해야 하며, 비밀번호에 유효기간을 설정하고 주기적으로 변경할 필요가 있다.
		 ∙ 생성한 비밀번호에 12345678 등과 같은 일련번호, 전화번호 등과 같은 쉬운 문자열 이 포함되지 않아야 함
		 ∙ love, happy 등과 같은 잘 알려진 단어 또는 키보드 상에서 나란히 있는 문자열도 포함되지 않아야 함
	
	[국가 정보보안 기본지침]
		 ∙ 비밀번호 설정 강화 : 영문/숫자/특수문자 9자리 이상 혼용
	
	** 사용방법
	관리자 비밀번호 체크  : PW_CheckByType(비밀번호, 확인번호, 비밀번호처리유형)
	사용자 비밀번호 체크  : PW_Check(비밀번호, 확인번호)
*/
	
	/* eher_4656
	/[~!\@#$%^&\=+|;"<,.>'?]/ //기존패턴
	"-_=+\|()*&^%$#@!~`?></;,.:'";
	var re = /[~!@\#$%^&*\()\-=+_'\"]/gi; //특수문자
	
	// javascript
	var patt_k = /([가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i; // 한글 정규식
	var patt_e = /[A-z]/i; // 영문자 정규식
	var patt_w = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi; // 특수문자 정규식
	var patt_n = /[\d]/i; // 숫자 정규식
	var patt_4num1 = /(\w)\1\1\1/; // 같은 영문자&숫자 연속 4번 정규식
	var patt_4num2 = /([\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"])\1\1\1/; // 같은 특수문자 연속 4번 정규식
	var patt_4num3 = /([가-힣ㄱ-ㅎㅏ-ㅣ\x20])\1\1\1/; // 같은 한글 연속 4번 정규식
	var patt_cont = /(0123)|(1234)|(2345)|(3456)|(4567)|(5678)|(6789)|(7890)/; // 연속된 숫자 정규식
	 */

	var PW_TypeCnt = 0;
	var PW_MaxLen = 20;  //최대길이
	var PW_UserLen1 = 8; //3종류 최소길이
	var PW_UserLen2 = 8;//2종류 최소길이
	var PW_AdminLen = 8; //관리자 최소길이
	var PW_Pattern_eng1 = /[(a-z)]/;
	var PW_Pattern_eng2 = /[(A-Z)]/;
	var PW_Pattern_num = /[0-9]/;
	var PW_Pattern_sp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	var PW_Pattern_type = new Array("love","happy","12345678","qwerty");
	
	var PW_Test1_Msg = "비밀번호는 "+PW_AdminLen+"~"+PW_MaxLen+"자리 이내의 \n" +
					  " '영문/숫자/특수문자'를 조합하여 사용해야 합니다.\n\n" +
					  "예)korea_2012 \n" +
					  " -> 영문(korea), 숫자(2012), 특수문자(_), 10자리";
	var PW_Test2_Msg = "비밀번호는 아래 규칙에 따라 작성해주시기 바랍니다. \n" +
					  " * 문자유형:영대문자, 영소문자, 숫자, 특수문자\n" +
					  " > 2가지유형 혼합시 "+PW_UserLen2+"자리 이상.\n" +
					  " > 3가지유형 혼합시 "+PW_UserLen1+"자리 이상.";
	
	function PW_Check(pw1, pw2){
		var type = 'type1';
		return PW_CheckByType(pw1, pw2, type);
	}
	
	function PW_CheckByType(pw1, pw2, type){
		PW_TypeCnt=0;
		
		if(PW_isSet(pw1) && PW_Compare(pw1, pw2)
				&& PW_Pattern(pw1) && PW_Test(pw1, type)){
			return true;
		} else return false;
	}
	
	function PW_isSet(valeu){
		//비밀번호 입력여부 확인
		if(valeu.length==0){
			alert("비밀번호를 입력하세요.");
			return false;
		} else return true;
	}
	
	function PW_Compare(pw1, pw2){
		//입력한 비밀번호 일치여부 확인
		if(pw2.length > 1 && pw1 != pw2){
			alert("입력하신 비밀번호가 일치하지 않습니다.");
			return false;
		} else return true;
	}
	
	function PW_Pattern(pw1){
		//비밀번호 패턴 확인
		for (var i = 0; i < PW_Pattern_type.length; i++){
			if(pw1.match(".*" + PW_Pattern_type[i] + ".*")) {
				alert("유추하기 쉬운 패턴이 포함되었습니다. \n다른 비밀번호를 이용하시기 바랍니다.\n ex)"+ PW_Pattern_type);
				return false;
			}
		}
		return true;
	}
	
	function PW_Test(pw1, type){
		if(type=='') type='type1';
		//비밀번호 작성규칙 확인
		if(type == 'type1'){
			if(PW_Test1(pw1))return true;
			else{
				alert(PW_Test1_Msg);
				return false;
			}
		}else if(type=='type2'){
			if(PW_Test2(pw1))return true;
			else{
				alert(PW_Test2_Msg);
				return false;
			}
		}
	}
	
	function PW_Test1(pw1){
		if(PW_Pattern_sp.test(pw1) || PW_Pattern_sp.test(pw1))PW_TypeCnt+=1;
		if(PW_Pattern_num.test(pw1))PW_TypeCnt+=1;
		if(PW_Pattern_eng1.test(pw1) || PW_Pattern_eng2.test(pw1))PW_TypeCnt+=1;
		if(PW_TypeCnt == 3 && pw1.length >= PW_AdminLen && pw1.length <= PW_MaxLen){
			return true;
		}else{
			return false;
		}
	}
	
	function PW_Test2(pw1){
		if(PW_Pattern_sp.test(pw1))PW_TypeCnt+=1;
		if(PW_Pattern_num.test(pw1))PW_TypeCnt+=1;
		if(PW_Pattern_eng1.test(pw1))PW_TypeCnt+=1;
		if(PW_Pattern_eng2.test(pw1))PW_TypeCnt+=1;
		if(PW_TypeCnt >= 3 && pw1.length >= PW_UserLen1 && pw1.length <= PW_MaxLen)
			return true;
		else if(PW_TypeCnt == 2  && pw1.length >= PW_UserLen2 && pw1.length <= PW_MaxLen)
			return true;
		else return false;
	}