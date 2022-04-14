package egovframework.dev.cmm.util;

import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

/**
 * 이미지 관련 유틸
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

public class ImageUtil {
	
	public static void makeThumnailImage(String filepath, int width, int height) throws IOException {
		File file = new File(filepath);
		
		String filePath = file.getPath();
		//String ext = "";
		//int dotIndex = filePath.lastIndexOf(".");
		//if (dotIndex > 0) 	ext = filePath.substring(dotIndex+1);
		
		File thumbFile = new File(String.format("%sthumb_%s_%s", filePath.replace(file.getName(),""), width, file.getName()));
		// 썸네일 이미지가 이미 존재할 경우 종료
		if(thumbFile.exists()) return;
		// 이미지 로드
		BufferedImage bi = ImageIO.read(file);
		// 이미지 크기 조정
		
		if((float)width > bi.getWidth() ){	//이미지보다 만들 섬네일이 클때
			width = bi.getWidth();
			height = bi.getHeight();
		}else{									//가로는 고정 세로만 비율 맞춤
			height = (int)(bi.getHeight() * (float)width/bi.getWidth());
		}
		/*
		if((float)width/bi.getWidth() > (float)height/bi.getHeight()){
			//세로일때
			width = (int)(bi.getWidth() * (float)height/bi.getHeight());
		}else{
			//가로일때
			height = (int)(bi.getHeight() * (float)width/bi.getWidth());
		}
		*/
		
		BufferedImage thumbImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		Graphics2D g2 = thumbImg.createGraphics();
		g2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g2.drawImage(bi, 0, 0, width, height, null);
		g2.dispose();
		
		// 썸네일 저장(jpg형태로 저장하며 확장자 명 기존첨부파일과 동일하게 생략됨)
		ImageIO.write(thumbImg, "jpg", thumbFile);
	}
	
}
