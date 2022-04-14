package egovframework.plani.template.project.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovBasicLogger;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.dev.cmm.service.CmmMap;
import egovframework.dev.cmm.service.CmmService;
import egovframework.dev.cmm.util.ControllerUtil;
import egovframework.dev.cmm.util.FileMngUtil;
import egovframework.dev.cmm.util.StringUtil;
import egovframework.plani.custom.memsvc.vo.MemberVO;
import egovframework.plani.template.project.service.ProjectService;
import egovframework.plani.template.project.vo.ProjectVO;
import egovframework.plani.template.cmm.exceptions.CmmnException;
import egovframework.plani.template.cmm.utils.CrudStrategy;
import egovframework.plani.template.cmm.utils.CrudTemplate;
import egovframework.plani.template.cmm.utils.EgovSessionCookieUtil;
import egovframework.plani.template.cmm.utils.ExcelDownUtil;
import egovframework.plani.template.cmm.utils.MessageHelper;
import egovframework.plani.template.cmm.utils.ResponseResultHelper;
import egovframework.plani.template.cmm.utils.UserInfoHelper;
import egovframework.plani.template.man.log.service.ManlogService;

@Controller
@RequestMapping("/project")
public class ProjectController {

	@Resource(name = "projectService")
	private ProjectService projectService;
	@Resource
	private CrudTemplate crudTemplate;

	/** ManlogService */
	@Resource(name = "manlogService")
	protected ManlogService manlogService;
	
	@Resource(name = "cmmService")
    private CmmService cmmService;

    @Resource(name = "FileMngUtil")
    private FileMngUtil fileUtil;

	/**
	 * 리스트 페이지 출력
	 * 
	 * @param scheduleVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */

	@RequestMapping("list")
	public String list(final @ModelAttribute("projectVO") ProjectVO projectVO, Model model,
			HttpServletRequest request) throws Exception {
		
		CmmMap params = new CmmMap();
    	params = ControllerUtil.getAllAttributeToCmmMap(request);
    	params.put("sys_cd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pid_cd", "stop");		//프로젝트 코드
    	
    	MemberVO sessionUserData = UserInfoHelper.getLoginData();
		params.put("pbdReqMemId", sessionUserData.getUser_id());
    	if(sessionUserData != null){
    		if(sessionUserData.getUser_id().indexOf("sjtech")>-1){
    			params.put("memGroupCd", "sjtech");
    		}
    	}
    	
    	projectVO.setPid_cd("stop");
    	
    	params.put("pageIndex", params.getInt("pageIndex") < 1 ? 1 : params.getInt("pageIndex"));
		params.put("pageUnit", params.getInt("pageUnit") < 1 ? 10 : params.getInt("pageUnit"));
    	
		int userlv = (int) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100) {
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);
		}
		// 페이징 목록 처리
		crudTemplate.pagingList(request, model, projectVO, new CrudStrategy<ProjectVO>() {
			@Override
			public int totalCount() throws Exception {
				return projectService.selectProjectListTotCnt(projectVO);
			}

			@Override
			public List<ProjectVO> pagingList() throws Exception {
				return projectService.selectProjectList(projectVO);
			}
		});
		
		//업무편람 (통계수치)
		CmmMap stats = projectService.selectProjectBoardDataStats(params);
		
		model.addAttribute("stats", stats);
		model.addAttribute("vo",params);

		manlogService.insertManlog(request, "PMS_MAN", "PMS관리", "목록 조회", "L");
		return "/project/list";
	}

	
	//게시글 수정 
    @RequestMapping("update")
    public String update(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	/** request Attribute to CmmMap **/
    	CmmMap params = new CmmMap();
    	params = ControllerUtil.getAllAttributeToCmmMap(request);
    	params.put("sysCd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pidCd", "stop");		//프로젝트 코드 
    	params.put("pageIndex", params.getInt("pageIndex") < 1 ? 1 : params.getInt("pageIndex"));
		params.put("pageUnit", params.getInt("pageUnit") < 1 ? 10 : params.getInt("pageUnit"));
    	//System.out.println("params="+params.toString());
    	
    	String returnJspUrl = "/project/updateReq";
    	MemberVO sessionUserData = UserInfoHelper.getLoginData();
		params.put("pbdReqMemId", sessionUserData.getUser_id());
    	if(sessionUserData != null){
    		if(sessionUserData.getUser_id().indexOf("sjtech")>-1){
    			returnJspUrl = "/project/updateRes";
    		}
    	}
    	
    	try {
    		//요청내용
    		CmmMap result=projectService.selectProjectBoardData(params);
    		
    		List<CmmMap> fileList = projectService.selectProjectBoardFileList(params);
    		model.addAttribute("fileList",fileList);
    		
    		model.addAttribute("result",result);
    		model.addAttribute("vo",params);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return returnJspUrl;		
	}

	
	/**
	 * 쓰기 페이지
	 * 
	 * @param scheduleVO
	 * @param model
	 * @param request
	 * @exception Exception
	 * @return String
	 * 
	 */
	@RequestMapping(value = "write", method = RequestMethod.GET)
	public String write(@ModelAttribute("projectVO") ProjectVO projectVO, Model model,
			HttpServletRequest request) throws Exception {
		//System.out.println("write:GET");
		CmmMap params = new CmmMap();
    	params = ControllerUtil.getAllAttributeToCmmMap(request);
    	params.put("pageIndex", params.getInt("pageIndex") < 1 ? 1 : params.getInt("pageIndex"));
		params.put("pageUnit", params.getInt("pageUnit") < 1 ? 10 : params.getInt("pageUnit"));
    	model.addAttribute("vo",params);
    	
    	params.put("sysCd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pidCd", "stop");		//프로젝트 코드 
    	//System.out.println("params="+params.toString());
    	
    	try {
    		CmmMap result = new CmmMap();
    		if(!"".equals(params.getString("pbdSeq"))) result = projectService.selectProjectBoardData(params);
    		model.addAttribute("result",result);
    		
		} catch (Exception e) {
			System.out.println("error Page : "+params.getString("currentURL")+" - "+params.getString("currentAddr"));
			e.printStackTrace();
		}

		return "/project/write";
	}


	//게시글 작성 처리 
	@RequestMapping(value = "jsonWrite", method = RequestMethod.POST)
    public String jsonWrite(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	response.setCharacterEncoding(request.getCharacterEncoding());
		request.setCharacterEncoding("UTF-8");
		
    	CmmMap params = new CmmMap();		//등록 및 list 호출시 필요한 parameter를 넣기위한 맵
    	params = ControllerUtil.getAllAttributeToCmmMap(request);   
    	params.put("sysCd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pidCd", "stop");		//프로젝트 코드 
    	
    	CmmMap msgMap = new CmmMap();	//메세지, returnUrl 등 필요한 정보를 넣기위한 맵
    	CmmMap jsonMap = new CmmMap();	//각종 map을 모아 최종적으로 jsonString을 만들어 낸다 
    	
    	try {
    		
    		/** 기본값 채움  **/
    		params.put("pbdYear", params.getString("nowTimeStamp").substring(0, 4));
    		
    		// 세션 사용자 정보
    	    MemberVO sessionUserData = UserInfoHelper.getLoginData();
    	    
    		params.put("pbdReqMemId", sessionUserData.getUser_id());
    		params.put("pbdReqMemNm", sessionUserData.getUser_nm());
    		
    		System.out.println("params:"+params);
    		/** 등록 : Editor 첨부파일을 별도 테이블에 넣을 경우 params.getString("editorAtchFileId") 을 호출하여 사용 **/
    		projectService.insertProjectBoardData(params);
    		int pbdSeq = params.getInt("pbdSeq");
    		params.put("pbdSeq", pbdSeq);
    		
    		projectService.insertSelectProjectBoardLog(params);
    		msgMap.put("pbdSeq","pbdSeq");
    		
    		//** 첨부파일 **//
    		String[] atchFileId = request.getParameterValues("atchFileId");
    		if(atchFileId != null){
    			for(int i=0;i<atchFileId.length;i++){
    				CmmMap fileMap = new CmmMap();
    				fileMap.put("pbdSeq", pbdSeq);
    				fileMap.put("pbfType", "req");
    				fileMap.put("atchFileId", atchFileId[i]);
    				projectService.insertProjectBoardFile(fileMap);
    			}
    		}
    		
    		/** 메세지, returnUrl 등 필요한 정보 표출 **/
    		msgMap.put("status","success");
    		msgMap.put("msg","정상적으로 등록 되었습니다.");
    		
    		/** 각종 맵을 모아 최종적으로 jsonString을 만들어 낸다 **/
    		///jsonMap.put("list", ControllerUtil.cmmMapListToJSON(list));			//jsonMap에 넣을땐 객체의 유형에 따라 ControllerUtil.cmmMap.... 을 호출 
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		//jsonMap에 넣을땐 객체의 유형에 따라 ControllerUtil.cmmMap.... 을 호출
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
		} catch (Exception e) {
			msgMap.put("status","fail");
    		msgMap.put("msg","등록에 실패하였습니다.");
    		
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
			e.printStackTrace();
		}
    	
    	return "/project/jsonReturn";	
	}
	
	//게시글 수정 처리 
    @RequestMapping("jsonUpdate")
    public String jsonUpdate(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	response.setCharacterEncoding(request.getCharacterEncoding());
		request.setCharacterEncoding("UTF-8");
    	
    	CmmMap params = new CmmMap();		//등록 및 list 호출시 필요한 parameter를 넣기위한 맵
    	params = ControllerUtil.getAllAttributeToCmmMap(request);
    	params.put("sysCd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pidCd", "stop");		//프로젝트 코드 
    	
    	// 세션 사용자 정보
	    MemberVO sessionUserData = UserInfoHelper.getLoginData();

    	System.out.println("params="+params.toString());
    	
    	CmmMap msgMap = new CmmMap();	//메세지, returnUrl 등 필요한 정보를 넣기위한 맵
    	CmmMap jsonMap = new CmmMap();	//각종 map을 모아 최종적으로 jsonString을 만들어 낸다 
    	
    	try {
    		
    		/** 등록 **/
    		String[] atchFileId = request.getParameterValues("atchFileId");

        	if(sessionUserData != null){
        		if(sessionUserData.getUser_id().indexOf("sjtech")>-1){
        			params.put("pbdResMemId", sessionUserData.getUser_id());
        			params.put("pbdResMemNm", sessionUserData.getUser_nm());
        			
        			projectService.updateProjectBoardDataRes(params);
        			
        			/** 첨부파일 **/
        			params.put("pbfType", "res");
        			projectService.deleteProjectBoardFile(params);
        			if(atchFileId != null){
        				for(int i=0;i<atchFileId.length;i++){
                			CmmMap fileMap = new CmmMap();
                    		fileMap.put("pbdSeq", params.getString("pbdSeq"));
                    		fileMap.put("pbfType", "res");
                    		fileMap.put("atchFileId", atchFileId[i]);
                    		projectService.insertProjectBoardFile(fileMap);
                		}
        			}
        			
        		}else{
        			params.put("pbdReqMemId", sessionUserData.getUser_id());
        			params.put("pbdReqMemNm", sessionUserData.getUser_nm());
        			
        			projectService.updateProjectBoardDataReq(params);
        			
        			/** 첨부파일 **/
        			params.put("pbfType", "req");
        			projectService.deleteProjectBoardFile(params);
        			if(atchFileId != null){
	            		for(int i=0;i<atchFileId.length;i++){
	            			CmmMap fileMap = new CmmMap();
	            			fileMap.put("pbdSeq", params.getString("pbdSeq"));
	                		fileMap.put("pbfType", "req");
	                		fileMap.put("atchFileId", atchFileId[i]);
	                		projectService.insertProjectBoardFile(fileMap);
	            		}
        			}
        		}
        	}

    		/** 메세지, returnUrl 등 필요한 정보 표출 **/
    		msgMap.put("status","success");
    		msgMap.put("msg","정상적으로 수정 되었습니다.");
    		
    		/** 각종 맵을 모아 최종적으로 jsonString을 만들어 낸다 **/
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		//jsonMap에 넣을땐 객체의 유형에 따라 ControllerUtil.cmmMap.... 을 호출
    		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
		} catch (Exception e) {
			msgMap.put("status","fail");
    		msgMap.put("msg","수정에 실패하였습니다.");
			
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
			System.out.println("error Page : "+params.getString("currentURL")+" - "+params.getString("currentAddr"));
			e.printStackTrace();
		}
    	
    	return "/project/jsonReturn";	
	}
    
    @RequestMapping("jsonFileUpload")
    public String jsonFileUpload(final MultipartHttpServletRequest multiRequest, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
    	response.setCharacterEncoding(request.getCharacterEncoding());
  		request.setCharacterEncoding("UTF-8");

  		CmmMap msgMap = new CmmMap();	//메세지, returnUrl 등 필요한 정보를 넣기위한 맵
      	CmmMap jsonMap = new CmmMap();	//각종 map을 모아 최종적으로 jsonString을 만들어 낸다
  		
  		try {
  		Map<String, MultipartFile> files = multiRequest.getFileMap();
    	List<FileVO> result = null;
  	    List<CmmMap> fileList = new ArrayList<CmmMap>();
      	String KeyStr = "Y".equals(request.getParameter("isEditor")) ? "EDITOR_" : "FILE_";	//에디터파일인지에 대한 구분
  		
      	    
      	    if (!files.isEmpty()) {
      	    	result = fileUtil.parseFileInf(files, KeyStr, 0);
      	    	
      	    	projectService.insertFileInfs(result);
      	    	
      	    	for(int i=0; i < result.size(); i++){
    	  	  		CmmMap cvo = new CmmMap();
    				cvo.put("fileExtsn",result.get(i).getFileExtsn());
    				cvo.put("fileStreCours",result.get(i).getFileStreCours());
    				cvo.put("fileMg",result.get(i).getFileMg());
    				cvo.put("orignlFileNm",result.get(i).getOrignlFileNm());
    				cvo.put("streFileNm",result.get(i).getStreFileNm());
    				cvo.put("atchFileId",result.get(i).getAtchFileId());
    				cvo.put("fileSn",result.get(i).getFileSn());
    				cvo.put("logicFileStreCours",result.get(i).getLogicFileStreCours());
    				fileList.add(cvo);
      	  		}
  	  	    }
	      	/** 메세지, returnUrl 등 필요한 정보 표출 **/
      		msgMap.put("status","success");
      		msgMap.put("msg","정상적으로 등록 되었습니다.");
      		
      		/** 각종 맵을 모아 최종적으로 jsonString을 만들어 낸다 **/
      		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		
      		jsonMap.put("fileList",ControllerUtil.cmmMapListToJSON(fileList));
      		
      		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
		} catch (Exception e) {
			msgMap.put("status","fail");
    		msgMap.put("msg","파일업로드에 실패하였습니다.");
			
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
			
			e.printStackTrace();
		}
  		return "/project/jsonReturn";
    }
    
  //게시글 삭제 처리 : 단일
    @RequestMapping("jsonDelete.do")
    public String jsonDelete(HttpServletRequest request, HttpServletResponse response, ModelMap model, @PathVariable String sysCd, @PathVariable String pidCd) throws Exception {
    	response.setCharacterEncoding(request.getCharacterEncoding());
		request.setCharacterEncoding("UTF-8");
    	
    	CmmMap params = new CmmMap();		//등록 및 list 호출시 필요한 parameter를 넣기위한 맵
    	params = ControllerUtil.getAllAttributeToCmmMap(request);
    	params.put("sysCd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pidCd", "stop");		//프로젝트 코드 
    	System.out.println("params="+params.toString());
    	
    	CmmMap msgMap = new CmmMap();	//메세지, returnUrl 등 필요한 정보를 넣기위한 맵
    	CmmMap jsonMap = new CmmMap();	//각종 map을 모아 최종적으로 jsonString을 만들어 낸다 
    	
    	try {
    		/** 삭제 **/
    		projectService.deleteProjectBoardData(params);

    		/** 메세지, returnUrl 등 필요한 정보 표출 **/
    		msgMap.put("status","success");
    		msgMap.put("msg","정상적으로 삭제 되었습니다.");
    		
    		/** 각종 맵을 모아 최종적으로 jsonString을 만들어 낸다 **/
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		//jsonMap에 넣을땐 객체의 유형에 따라 ControllerUtil.cmmMap.... 을 호출
    		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
		} catch (Exception e) {
			msgMap.put("status","fail");
    		msgMap.put("msg","삭제에 실패하였습니다.");
			
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
    		System.out.println("error Page : "+params.getString("currentURL")+" - "+params.getString("currentAddr"));
			e.printStackTrace();
		}
    	
    	return "/project/jsonReturn";	
	}
    
    //게시글 삭제 처리 : 일괄
    @RequestMapping("jsonArrayDelete.do")
    public String jsonArrayDelete(HttpServletRequest request, HttpServletResponse response, ModelMap model, @PathVariable String sysCd, @PathVariable String pidCd) throws Exception {
    	response.setCharacterEncoding(request.getCharacterEncoding());
		request.setCharacterEncoding("UTF-8");
    	
    	CmmMap params = new CmmMap();		//등록 및 list 호출시 필요한 parameter를 넣기위한 맵
    	params = ControllerUtil.getAllAttributeToCmmMap(request);
    	params.put("sysCd", "as");	//ws - workSystem 업무시스템, hs - homeSystem 사용자, as - adminSystem 관리자
    	params.put("pidCd", "stop");		//프로젝트 코드 
    	System.out.println("params="+params.toString());
    	
    	CmmMap msgMap = new CmmMap();	//메세지, returnUrl 등 필요한 정보를 넣기위한 맵
    	CmmMap jsonMap = new CmmMap();	//각종 map을 모아 최종적으로 jsonString을 만들어 낸다 
    	
    	try {
    		/** 삭제 **/
    		String[] checkedValue = params.getString("checkedValue").split(",");
    		if(checkedValue.length > 0){
    			for(int i=0; i<checkedValue.length; i++){
    				CmmMap dataMap = new CmmMap();
    				dataMap.put("brdSeq", checkedValue[i]);
    				projectService.deleteProjectBoardData(dataMap);
    			}
        		/** 메세지, returnUrl 등 필요한 정보 표출 **/
        		msgMap.put("status","success");
        		msgMap.put("msg","정상적으로 삭제 되었습니다.");
    		}else{
    			msgMap.put("status","fail");
        		msgMap.put("msg","필요한 값이 없습니다.");
    		}
    		
    		/** 각종 맵을 모아 최종적으로 jsonString을 만들어 낸다 **/
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		//jsonMap에 넣을땐 객체의 유형에 따라 ControllerUtil.cmmMap.... 을 호출
    		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
		} catch (Exception e) {
			msgMap.put("status","fail");
    		msgMap.put("msg","삭제에 실패하였습니다.");
			
    		jsonMap.put("result", ControllerUtil.cmmMapToJSON(msgMap));		
    		model.addAttribute("jsonString",ControllerUtil.jsonMapToMsg(jsonMap));
    		
    		System.out.println("error Page : "+params.getString("currentURL")+" - "+params.getString("currentAddr"));
			e.printStackTrace();
		}
    	
    	return "/project/jsonReturn";	
	}

	
	@RequestMapping(value = "jsonFileDown.do")
	public void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setCharacterEncoding(request.getCharacterEncoding());
  		request.setCharacterEncoding("UTF-8");
  		//response.setContentType("application/octet-stream;charset=UTF-8");
  		
  		// 세션 사용자 정보
	    MemberVO sessionUserData = UserInfoHelper.getLoginData();
  		if(sessionUserData != null){
  			CmmMap params = new CmmMap();		
        	params = ControllerUtil.getAllAttributeToCmmMap(request);
    		
    		String atchFileId = params.getString("atchFileId");
    		String fileSn = params.getString("fileSn");
    		if("".equals(fileSn)) fileSn = "0";

			FileVO fileVO = new FileVO();
			fileVO.setAtchFileId(atchFileId);
			fileVO.setFileSn(fileSn);
			FileVO fvo = projectService.selectFileInf(fileVO);

			File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
			int fSize = (int) uFile.length();

			if (fSize > 0) {
				String mimetype = "application/x-msdownload";

				//response.setBufferSize(fSize);	// OutOfMemeory 발생
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				setDisposition(fvo.getOrignlFileNm(), request, response);
				response.setContentLength(fSize);

				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close();
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				BufferedInputStream in = null;
				BufferedOutputStream out = null;

				try {
					in = new BufferedInputStream(new FileInputStream(uFile));
					out = new BufferedOutputStream(response.getOutputStream());

					FileCopyUtils.copy(in, out);
					out.flush();
				} catch (IOException ex) {
					// 다음 Exception 무시 처리
					// Connection reset by peer: socket write error
					EgovBasicLogger.ignore("IO Exception", ex);
				} finally {
					EgovResourceCloseHelper.close(in, out);
				}

			} else {
				response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('파일이 존재하지 않습니다.'); history.back(-1);</script>");
				out.flush(); 
			}
  		}else{
  			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('파일다운 권한이 없습니다.'); history.back(-1);</script>");
			out.flush(); 
  		}
  		
  		
		
	}
	
	public static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Trident")) { // IE11 문자열 깨짐 방지
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}
	
	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Trident") > -1) { // IE11 문자열 깨짐 방지
			return "Trident";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	/**
	 * 사용자 목록의 엑셀 다운로드 요청을 처리한다.
	 * 
	 * @param usrVO
	 *            : 엑셀 다운로드 할 조건이 담긴 사용자 VO
	 * @param request
	 * @param model
	 * @exception Exception
	 */
	@RequestMapping("xlsProjectList")
	public void xlsProjectList(@ModelAttribute("projectVO") ProjectVO projectVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		try {
		int userlv = (Integer) EgovSessionCookieUtil.getSessionAttribute(request, "SESS_USR_LV");
		if (userlv > 100)
			throw new CmmnException(MessageHelper
					.getMessage("INSUFFICIENT-PRIVILEGES")/* 권한이 부족합니다. */);

		ExcelDownUtil xlsDownUtil = new ExcelDownUtil();
		ArrayList colinfoList = new ArrayList();

		String[][] col_name = { { "PBD_NO", "요청번호" }, { "PBD_REQ_TYPE", "요청구분" }, { "PBD_REQ_DT", "요청일" }, { "PBD_REQ_MEM_NM", "요청자" }, { "PBD_CATEGORY", "점검항목" },	
				{ "PBD_REQ_TITLE", "제목" },{ "PBD_RES_TYPE", "처리구분" },{ "PBD_RES_MEM_NM", "조치자" },{ "PBD_DUE_DT", "완료요청일" } };

		for (int i = 0; i < col_name.length; i++) {
			HashMap ifmap = new HashMap();
			ifmap.put("COL_NAME", col_name[i][0]);
			ifmap.put("COL_INFO", col_name[i][1]);
			colinfoList.add(ifmap);
		}



		List projectOrgList = projectService.selectExcelList(projectVO);

		/************************************************************
		 * 질의 결과를 그대로 엑셀에 저장할 수 없으므로 데이터를 가공한다. 그대로 저장해도 되는 경우(가공이 필요없는 경우) 이부분은
		 * 생략한다....
		 ************************************************************/
		List projectXlsList = new ArrayList();
		for (int i = 0; i < projectOrgList.size(); i++) {
			ProjectVO vo = (ProjectVO) projectOrgList.get(i);

			HashMap rsmap = new HashMap();
			rsmap.put("PBD_NO", vo.getPbd_no());
			rsmap.put("PBD_REQ_TYPE", vo.getPbd_req_type());
			rsmap.put("PBD_REQ_DT", vo.getPbd_req_dt());
			rsmap.put("PBD_REQ_MEM_NM", vo.getPbd_req_mem_nm());
			rsmap.put("PBD_CATEGORY", vo.getPbd_category());
			rsmap.put("PBD_REQ_TITLE", vo.getPbd_req_title());
			rsmap.put("PBD_RES_TYPE", vo.getPbd_res_type());
			rsmap.put("PBD_RES_MEM_NM", vo.getPbd_res_mem_nm());
			rsmap.put("PBD_DUE_DT", vo.getPbd_due_dt());

			projectXlsList.add(rsmap);
		}

		String fileName = "PMS 정보";

		// ////////////////////////////////////////////////////////////////////////////////////////////
		//
		// 관리자 로그 저장 C/R/U/D L : 목록 X : 엑셀저장
		manlogService.insertManlog(request, "PMS_MAN", "PMS관리", "PMS 목록 엑셀저장", "X");
		//
		// ////////////////////////////////////////////////////////////////////////////////////////////

		xlsDownUtil.ExcelWrite(response, projectXlsList, colinfoList, fileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
