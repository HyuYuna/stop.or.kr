package egovframework.plani.template.cmm.service;

import java.util.List;
import egovframework.plani.template.cmm.vo.MessageVO;

public interface MessageService {


  /**
   * SMS를 발송한다.
   * 
   * @param vo
   */
  public Integer sendSms(MessageVO vo) throws Exception;

  /**
   * MMS를 발송한다.
   * 
   * @param vo
   */
  public Integer sendMms(MessageVO vo) throws Exception;

  /**
   * 대량으로 MMS를 발송한다.
   * 
   * @param vo
   * @throws Exception
   */
  public void sendMms(List<MessageVO> list) throws Exception;


}
