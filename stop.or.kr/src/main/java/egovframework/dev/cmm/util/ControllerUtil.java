package egovframework.dev.cmm.util;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import egovframework.dev.cmm.service.CmmMap;

/**
 * 컨트롤러 관련 유틸
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

public class ControllerUtil {

	@SuppressWarnings("unchecked")
	public static CmmMap getAllAttributeToCmmMap(HttpServletRequest request) throws IOException {
		CmmMap params = new CmmMap();
		
		for (Enumeration<String> en = request.getParameterNames(); en.hasMoreElements();) {
			String attribute = en.nextElement();
			String attributeValue = request.getParameter(attribute);
			params.put(attribute, attributeValue);
		}
		
		/** 개발에 필요한 값들 추가 시작 **/
		String currentURL = request.getRequestURI();
		String currentAddr = request.getHeader("X-Forwarded-For");
		if (currentAddr == null || currentAddr.length() == 0 || "unknown".equalsIgnoreCase(currentAddr)) { 
		     currentAddr = request.getHeader("Proxy-Client-currentAddr"); 
		 } 
		 if (currentAddr == null || currentAddr.length() == 0 || "unknown".equalsIgnoreCase(currentAddr)) { 
		     currentAddr = request.getHeader("WL-Proxy-Client-currentAddr"); 
		 } 
		 if (currentAddr == null || currentAddr.length() == 0 || "unknown".equalsIgnoreCase(currentAddr)) { 
		     currentAddr = request.getHeader("HTTP_CLIENT_currentAddr"); 
		 } 
		 if (currentAddr == null || currentAddr.length() == 0 || "unknown".equalsIgnoreCase(currentAddr)) { 
		     currentAddr = request.getHeader("HTTP_X_FORWARDED_FOR"); 
		 } 
		 if (currentAddr == null || currentAddr.length() == 0 || "unknown".equalsIgnoreCase(currentAddr)) { 
		     currentAddr = request.getRemoteAddr(); 
		 }
		if(request.getQueryString() != null) currentURL = String.format("%s?%s", currentURL, request.getQueryString());
		params.put("currentURL", currentURL);
		params.put("currentHeader", request.getHeader("host"));
		params.put("currentAddr", currentAddr);
		params.put("servletPath", request.getServletPath().replace(".do", ""));
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat timeStampFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		params.put("nowDate", dateFormat.format(Calendar.getInstance().getTime()));
		params.put("nowTimeStamp", timeStampFormat.format(Calendar.getInstance().getTime()));
		/** 개발에 필요한 값들 추가 끝 **/
    	
		return params;
	}
	
	@SuppressWarnings("unchecked")
	public static HashMap<String, String> getAllAttribute(HttpServletRequest request) {
		HashMap<String, String> requestParams = new HashMap<String, String>();
		for (Enumeration<String> en = request.getParameterNames(); en.hasMoreElements();) {
			String attribute = en.nextElement();
			String attributeValue = request.getParameter(attribute);
			requestParams.put(attribute, attributeValue);
		}
		return requestParams;
	}
	public static HashMap<String, String> getAttributes(HttpServletRequest request, String[] args) {
		HashMap<String, String> requestParams = new HashMap<String, String>();
		try {
			for(int i = 0; i < args.length; i++) {
				String attributeValue = request.getParameter(args[i]);
				requestParams.put(args[i], attributeValue);
			}
		} catch(Exception e) {}
		return requestParams;
	}
	
	public static String toQueryString(HttpServletRequest request, String... args) {
		StringBuffer retStr = new StringBuffer();
		try {
			for(int i = 0; i < args.length; i++) {
				String value = request.getParameter(args[i]);
				retStr.append(String.format("%s%s=%s", 
					i == 0 ? "?" : "&", 
					args[i], 
					value == null ? "" : URLEncoder.encode(value, "UTF-8")
				));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return retStr.toString();
	}
	
	public static String makeScript(String message, String linkURL, String linkType) {
		
		/*
		 * 
<!DOCTYPE html><html lang='ko'><head><meta charset='UTF-8' /><meta http-equiv='X-UA-Compatible' content='IE=Edge, chrome=1' />

		 */
		
		StringBuffer script = new StringBuffer();
		//script.append("<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='ko' lang='ko'><head><title>페이지 전환</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><script type='text/javascript'>");
		script.append("<!DOCTYPE html><html lang='ko'><head><meta charset='UTF-8' /><meta http-equiv='X-UA-Compatible' content='IE=Edge, chrome=1' /><script type='text/javascript'>");
		if(!message.equals("")) script.append(String.format("alert('%s');", message));
		if(linkType.equals("back")) {
			script.append("self.history.back();");
		} else if(linkType.equals("replace")) {
			script.append(String.format("self.location.replace('%s');", linkURL));
		} else if(linkType.equals("close")) {
			script.append("top.close();");
		} else if(linkType.equals("openerReload")) {
			script.append("opener.location.reload();");
			script.append("top.close();");
		} else if(linkType.equals("none")) {
			// nothing...
		} else {
			script.append(String.format("self.location.href = '%s';", linkURL));
		}
		script.append("</script></head></html>");
		return script.toString();
	}
	
	public static String cmmMapListToJSON(List<CmmMap> dataList) {
		
		if (dataList == null || dataList.size() < 1)
			return "";

		StringBuffer result = new StringBuffer();

		// result header
		result.append("[");

		// each row
		for (int i = 0; i < dataList.size(); i++) {
			if (i > 0) result.append(",");
			// row header
			result.append("{");
			// each column
			CmmMap data = dataList.get(i);
			int j = 0;
			for(Object key : data.keySet()) {
				if (j > 0) result.append(",");
				String dataVal = data.get(key) == null ? "" : data.get(key).toString();
				result.append(String.format("\"%s\":\"%s\"",
					key,
					dataVal
						.replace("\\", "\\\\")
						.replace("\"", "\\\"")
						.replace("\r\n", "\\n")
						.replace("\n", "\\n")
						.replace("\r", "\\n")
				));
				j++;
			}
			// row footer
			result.append("}");
		}

		// result footer
		result.append("]");

		return result.toString();
	}
	
	public static String cmmMapToJSON(CmmMap data) {
		StringBuffer result = new StringBuffer();
		result.append("{");
		// each column
		int j = 0;
		for(Object key : data.keySet()) {
			if (j > 0) result.append(",");
			String dataVal = data.get(key) == null ? "" : data.get(key).toString();
			result.append(String.format("\"%s\":\"%s\"",
				key,
				dataVal
					.replace("\\", "\\\\")
					.replace("\"", "\\\"")
					.replace("\r\n", "\\n")
					.replace("\n", "\\n")
					.replace("\r", "\\n")
			));
			j++;
		}
		// row footer
		result.append("}");
		return result.toString();
	}
	
	public static String jsonMapToMsg(CmmMap data) {
		StringBuffer result = new StringBuffer();
		result.append("{");
		// each column
		int j = 0;
		for(Object key : data.keySet()) {
			if (j > 0) result.append(",");
			String dataVal = data.get(key) == null ? "" : data.get(key).toString();
			//if(!dataVal.contains("[")) dataVal = "["+dataVal;	
			//if(!dataVal.contains("]")) dataVal = dataVal+"]";
			result.append(String.format("\"%s\":%s",
				key,
				dataVal
			));
			j++;
		}
		// row footer
		result.append("}");
		return result.toString();
	}
	
	
	
	
	
	public static String listToJSON(List<HashMap<String, Object>> dataList) {
		if (dataList == null || dataList.size() < 1)
			return "";

		StringBuffer result = new StringBuffer();

		// result header
		result.append("[");

		// each row
		for (int i = 0; i < dataList.size(); i++) {
			if (i > 0) result.append(",");
			// row header
			result.append("{");
			// each column
			HashMap<String, Object> data = dataList.get(i);
			int j = 0;
			for(Object key : data.keySet()) {
				if (j > 0) result.append(",");
				String dataVal = data.get(key) == null ? "" : data.get(key).toString();
				result.append(String.format("\"%s\":\"%s\"",
					key,
					dataVal
						.replace("\\", "\\\\")
						.replace("\"", "\\\"")
						.replace("\r\n", "\\n")
						.replace("\n", "\\n")
						.replace("\r", "\\n")
				));
				j++;
			}
			// row footer
			result.append("}");
		}

		// result footer
		result.append("]");

		return result.toString();
	}
	
	public static String toJSON(HashMap<String, Object> data) {
		StringBuffer result = new StringBuffer();
		result.append("{");
		// each column
		int j = 0;
		for(Object key : data.keySet()) {
			if (j > 0) result.append(",");
			String dataVal = data.get(key) == null ? "" : data.get(key).toString();
			result.append(String.format("\"%s\":\"%s\"",
				key,
				dataVal
					.replace("\\", "\\\\")
					.replace("\"", "\\\"")
					.replace("\r\n", "\\n")
					.replace("\n", "\\n")
					.replace("\r", "\\n")
			));
			j++;
		}
		// row footer
		result.append("}");
		return result.toString();
	}
	
	public static String msgToJSON(String msg) {
		StringBuffer result = new StringBuffer();
		// header
		result.append("{\n\t");
		// msg
		result.append(msg.replaceAll("=", ":\"").replaceAll("&", "\",\n\t"));
		result.append("\"");
		// footer
		result.append("\n}");
		return result.toString();
	}

	
	
	public static void writeToResponse(HttpServletRequest request, HttpServletResponse response, String result) throws IOException {
		response.setContentType(request.getContentType());
		response.setCharacterEncoding(request.getCharacterEncoding());
		response.getWriter().write(result);

	}
	public static String getParameterViewString(HttpServletRequest request) {
		StringBuffer sb=new StringBuffer().append("PARAMETER =[\n");
		@SuppressWarnings("rawtypes")
		Enumeration names = request.getParameterNames();
		for(String p;names.hasMoreElements();) {
			p=names.nextElement().toString();
			sb.append("\t").append(p).append("=[").append(request.getParameter(p)).append("]\n");
		}
		sb.append("]");
		return sb.toString();
	}	
	
	
	
	
	
}
