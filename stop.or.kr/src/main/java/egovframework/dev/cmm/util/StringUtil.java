package egovframework.dev.cmm.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.util.NumberUtils;

/**
 * 문자열 관련 유틸
 * @author 개발팀 진효진
 * @since 2017.10.31
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  ------------   --------    ---------------------------
 *  2017.10.31  진효진          최초 생성
 *  </pre>
 */

public class StringUtil {
	
	public static String parseString(String source, String replace) {
		return source == null || source == "" ? replace : source;
	}
	
	public static int parseInt(String source, int replace) {
		try {
			return Integer.parseInt(source.replaceAll(",", ""), 10);
		} catch(Exception e) {
			return replace;
		}
	}
	
	public static int parseInt(Object source) {
		try {
			return NumberUtils.parseNumber(source.toString().replaceAll(",", ""), Integer.class).intValue();
		} catch(Exception e) {
			return 0;
		}
	}
	public static Integer parseInteger(Object source) {
		try {
			return NumberUtils.parseNumber(source.toString().replaceAll(",", ""), Integer.class).intValue();
		} catch(Exception e) {
			return null;
		}
	}
	
	public static long parseLong(String source, long replace) {
		try {
			return NumberUtils.parseNumber(source.toString().replaceAll(",", ""), Long.class).longValue();
		} catch(Exception e) {
			return replace;
		}
	}
	public static Long parseLong(String source) {
		if(source==null) return null;
		try {
			return NumberUtils.parseNumber(source.toString().replaceAll(",", ""), Long.class).longValue();
		} catch(Exception e) {
			return null;
		}
	}
	
	public static float parseFloat(Object source) {
		try {
			return NumberUtils.parseNumber(source.toString().replaceAll(",", ""), Float.class).floatValue();
		} catch(Exception e) {
			return 0;
		}
	}
	
	public static boolean isNumeric(String source) {
		try {
			Double.parseDouble(source);
			return true;
		} catch(Exception e) {
			return false;
		}
	}
	
	public static String randomStr(int length) {
		StringBuffer rndStr = new StringBuffer();
		char[] charset = "Aa1Bb2Cc3Dd4Ee5Ff6Gg7Hh8Ii9Jj1Kk2Ll3Mm4Nn5Oo6Pp7Qq8Rr9Ss1Tt2Uu3Vv4Ww5Xx6Yy7Zz".toCharArray();
		int charLen = charset.length;
		Random random = new Random();
		for (int i = 0; i < length; i++) {
			rndStr.append(charset[random.nextInt(charset.length) % charLen]);
		}
		return rndStr.toString();
	}
	
	public static String toString(String[] source, String delim) {
		StringBuffer ret = new StringBuffer();
		if(source != null) for(int i = 0; i < source.length; i++) {
			if(i > 0) ret.append(delim);
			ret.append(source[i]);
		}
		return ret.toString();
	}
	
	public static List<String> toList(String[] source) {
		List<String> retList = new ArrayList<String>();
		if(source != null) for(int i = 0; i < source.length; i++) retList.add(source[i]);
		return retList;
	}
	
	public static List<Integer> toIntList(String[] source) {
		List<Integer> retList = new ArrayList<Integer>();
		if(source != null) for(int i = 0; i < source.length; i++) retList.add(StringUtil.parseInt(source[i]));
		return retList;
	}
	
	public static List<Long> toLongList(String[] source) {
		List<Long> retList = new ArrayList<Long>();
		if(source != null) for(int i = 0; i < source.length; i++) retList.add(StringUtil.parseLong(source[i]));
		return retList;
	}
	
	public static String substringByte(String str, int i, String trail) {
		if(str == null) return "";
		String tmp = str;
		int slen = 0, blen = 0;
		char c;
		if(tmp.getBytes().length > i) {
			while(blen + 1 < i) {
				c = tmp.charAt(slen);
				blen++;
				slen++;
				if ( c > 127 ) blen++; // 2-byte character..
			}
			tmp = tmp.substring(0, slen) + trail;
		}
		return tmp;
	}
	
	public static String fileSizeFormat(long fileSize) {
		double size = fileSize;
		NumberFormat formatter = new DecimalFormat("#.#");
		if(size < 1024) return String.format("%sbyte", formatter.format(size));
		size = size / 1024;
		if(size < 1024) return String.format("%sKB", formatter.format(size));
		size = size / 1024;
		if(size < 1024) return String.format("%sMB", formatter.format(size));
		return "";
	}
	
	 /**
     *  <pre>
     *  입력받은 StringA[n] 값에서 StringB[n] 값을 제거하여 String[n]를 반환한다.
     *  @param strArray1 제거될 StringA 배열
     *  @param strArray2 제거할 StringB 배열
     *  @return  String[] 중복제거된 String 배열
     *  <b>Example)</b>
     *      String[] strArr = StringUtil.removeStr(String[] StringA, String[] StringB);
     *  </pre>
     */
	public static String[] removeArray(String[] strArray1, String[] strArray2) {
		if(strArray1 == null || strArray1.length == 0) return (String[])null;
		if(strArray2 == null || strArray2.length == 0) return strArray1;
		String r_str = "";
		boolean flag = true;
		for(int i = 0; i < strArray1.length; i++) {
			for(int j = 0; j < strArray2.length; j++) {
				if(strArray1[i].equals(strArray2[j])) {
					flag = false;
				}
			}
			if(flag) {
				if(!"".equals(r_str)) 
					r_str += ",";
				r_str += strArray1[i];
			}
			flag = true;
		}
		return "".equals(r_str) ? (String[])null : r_str.split(",");
	}
	
	/**
     * xssCheck 함수
     *
     * @param content 대상문자열
     * @return        문자열
     * 
     * @value xssTargetScript xss 필터링할 대상스크립트 목록
     * @value xssTargetTag xss 필터링할 대상테그 목록
     * 
     */
	private static String[] xssTargetScript = {"javascript", "vbscript", "expression", "applet", "meta", "xml", "blink", "link",  "script", "embed", "object", "iframe", "frame", "framset", "ilayer", "layer", "bgsound", "title", "base", "onreset", "onmove", "onstop",
	                       "eval", "innerHTML", "charset", "document", "string", "create", "append", "binding", "alert", "msgbox", "refresh", "cookie", "void", "href", "onpaste", "onstart", "onresize", "onrowexit", "onselect", "oncellchange",
	                       "onmousewheel", "ondataavailable", "onafterprint", "onafterupdate", "onmousedown", "onbeforeactivate", "onbeforeditfocus", "onbeforepaste", "onbeforeprint", "onbeforeunload", "onbeforeupdate", "onpropertychange", "ondatasetcomplete", "onlayoutcomplete", "onmousemove", "oncontextmenu", "oncontrolselect", "onreadystatechange", "onselectionchange", "onrowsinserted",
	                       "onactive", "oncopy", "oncut", "onclick", "onchange", "onbeforecut", "ondblclick", "ondeactivate", "ondrag", "ondragend", "ondragenter", "ondragleave", "ondragover", "ondragstart", "ondrop", "onerror", "onerrorupdate", "onfilterchange", "onfinish", "onfocus", "onresizestart", "onunload", "onselectstart",
	                       "onfocusin", "onfocusout", "onhelp", "onkeydown", "onkeypress", "onkeyup", "onrowsdelete", "onload", "onlosecapture", "onbounce", "onmouseenter", "onmouseleave", "onbefore", "onmouseover", "onmouseup", "onresizeend", "onabort", "onmoveend", "omnovestart", "onrowenter", "onsubmit", "onblur"
	};
	private static String[] xssTargetTag = {"<body","<form"};
	private static String[] xssTargetChar = {"\""};
	private static String[] xssTargetFile = {".jsp",".php",".asp",".exe",".bat",".sql"};

	public static String xssCheck(String content) {
		String value = content;
		String result = "clean";
		
		for(int i=0; i < xssTargetScript.length;i++){
			//value = value.replaceAll( xssTargetScript[i], "x-"+xssTargetScript[i]);
			if(value.indexOf(xssTargetScript[i]) != -1){
				result = "script";
			}
		}
		for(int i=0; i < xssTargetTag.length;i++){
			//value = value.replaceAll( xssTargetTag[i], ""+xssTargetTag[i]+"-x");
			if(value.indexOf(xssTargetTag[i]) != -1){
				result = "tag";
			}
		}
		/*
		for(int i=0; i < xssTargetChar.length;i++){
			//value = value.replaceAll( xssTargetChar[i], "");
			if(value.indexOf(xssTargetChar[i]) != -1){
				result = "char";
			}
		}
		*/
		for(int i=0; i < xssTargetFile.length;i++){
			//value = value.replaceAll( xssTargetFile[i], "");
			if(value.indexOf(xssTargetFile[i]) != -1){
				result = "file";
			}
		}
		return result;
	}
	
	public static String xssClean(String content) {
		String value = content;
		
		for(int i=0; i < xssTargetScript.length;i++){
			value = value.replaceAll( xssTargetScript[i], "");
		}
		for(int i=0; i < xssTargetTag.length;i++){
			value = value.replaceAll( xssTargetTag[i], "");
		}
		
		for(int i=0; i < xssTargetChar.length;i++){
			value = value.replaceAll( xssTargetChar[i], "");
		}
		
		for(int i=0; i < xssTargetFile.length;i++){
			value = value.replaceAll( xssTargetFile[i], "");
		}
		return value;
	}
	
	public static String sidoChange(String str) {
		if(str == null) return "";
		
		String result = "";
		
		String[] regularStr = {"강원도","경기도","경상남도","경상북도","광주광역시","대구광역시","대전광역시","부산광역시","서울특별시","세종특별자치시","울산광역시","인천광역시","전라남도","전라북도","제주특별자치도","충청남도","충청북도"};
		String[] irregularStr = {"강원","경기","경남","경북","광주","대구","대전","부산","서울","세종","울산","인천","전남","전북","제주","충남","충북"};
		
		for(int i=0; i<regularStr.length; i++){
			if(str.equals(regularStr[i])){
				result = irregularStr[i];
			}else if(str.equals(irregularStr[i])){
				result = regularStr[i];
			}
		}
		
		return result;
	}
	// 게시판 넥스트 아이디 만들기
	public static String NextBBSId(String lastId, String bbs_type, String bbs_attr){
		System.out.println("여기는 스트링 유틸== 게시판 아이디"+lastId+"타입"+bbs_type+"속성"+bbs_attr);
		if(lastId== "" || lastId.equals(null)) {
			System.out.println("널이야냐냐냐냐?");
	//		String type [] = {"일반게시판", "공지게시판", "익명게시판", "방명록게시판", "갤러리게시판", "유효게시판", "비공개게시판", "폼메일게시판", "dd", "zz", "aa"}; 
			String type [] = {"일반게시판", "공지게시판", "익명게시판", "방명록게시판", "인테리어스토리"}; 
			String attr [] = {"일반게시판", "갤러리게시판", "유효게시판"}; 

			int indexTY =0;
			int indexAT =0;
			String addIndexTY ="";
			String addIndexAT ="";
			
			for(int i=0; i<type.length; i++){
				if(bbs_type.equals(type[i])) {
					indexTY = i+1;
					if(indexTY <10) {
						addIndexTY ="0"+ Integer.toString(indexTY);
					}else{
						addIndexTY = Integer.toString(indexTY);
					}
				}
			}
			
			for(int i=0; i<attr.length; i++){
				if(bbs_attr.equals(attr[i])) {
					indexAT = i+1;
					if(indexAT <10) {
						addIndexAT = "0" + Integer.toString(indexAT);
					}else {
						addIndexAT = Integer.toString(indexAT);
					}
				}
			}

		String nextBBSId = "BBS"+"_TY"+addIndexTY +"_AT"+ addIndexAT+"_000001" ;	
		System.out.println(nextBBSId);
		return nextBBSId;
			
		}	else {
			System.out.println("게시판 아이디가 있을경우 타라");
			String nextBBSId =""; // 계산해서 리턴할 id
			String last_Id = lastId; // 파라미터로 받아온 id
			String MajorLabel = lastId.substring(0, 14); // Id 구분일련번호 앞자리
			String endLabel =lastId.substring(14);	// Id 고유일련번호 뒷자리
			
			int zerofild = last_Id.length() - MajorLabel.length(); // 0채울 자릿수 구하기
			
			int toInt_EndLable =(Integer.parseInt(endLabel))+1;
			String toString_EndLable = Integer.toString(toInt_EndLable);
			
			String result = leftPad(toString_EndLable, zerofild, '0'); // leftpad 함수로 빈 자리수 만큼 0 채움
			nextBBSId = MajorLabel + result; // 구분일련번호와 고유일련번호 합침
			
			return nextBBSId;
			
		}

	}
	// 왼쪽부터 0채우는 함수
	public static String leftPad(String str, int size, char padChar) {
		int f = size - str.length();
		System.out.println("str사이즈:"+str.length());
		String result = new String()	;
		
		while(f!=0)
		{
			if(f<0){
				break;
			}else {
				result = padChar + str;
				f -= 1;
			} str = result;
		}
		return str;
		
	}
	
	public static String unescape(String inp) {
	    String rtnStr = new String();
	    char [] arrInp = inp.toCharArray();
	    int i;
	    for(i=0;i<arrInp.length;i++) {
	        if(arrInp[i] == '%') {
	            String hex;
	            if(arrInp[i+1] == 'u') {    //유니코드.
	                hex = inp.substring(i+2, i+6);
	                i += 5;
	            } else {    //ascii
	                hex = inp.substring(i+1, i+3);
	                i += 2;
	            }
	            try{
	                rtnStr += new String(Character.toChars(Integer.parseInt(hex, 16)));
	            } catch(NumberFormatException e) {
	                rtnStr += "%";
	                i -= (hex.length()>2 ? 5 : 2);
	            }
	        } else {
	            rtnStr += arrInp[i];
	        }
	    }
	 
	    return rtnStr;
	}
	
	
	// SHA-256
	public static String SHA256Encrypt(String str, String privateKey){
		String SHA = ""; 
		// str 값과 privateKey 값을 합쳐 값을 편성함 
		str = str + privateKey;
		System.out.println("str="+str);
		
		try{
			MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
			sh.update(str.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			SHA = null; 
		}
		return SHA;
	}
	
	//모든 태그를 제거함
	public static String removeTag(String str) throws InvalidKeyException, UnsupportedEncodingException {
		
		str = str.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>","");
		
		return str;
	}
	
	
	
	
	
}
