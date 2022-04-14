package egovframework.plani.template.cmm.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import egovframework.plani.template.cmm.dao.MessageDAO;
import egovframework.plani.template.cmm.service.MessageService;
import egovframework.plani.template.cmm.vo.MessageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("messageService")
public class MessageServiceImpl extends EgovAbstractServiceImpl implements MessageService {

  /** AtchfileDAO */
  @Resource(name = "messageDAO")
  private MessageDAO messageDAO;

  @Override
  public Integer sendSms(MessageVO vo) throws Exception {
    return messageDAO.sendSms(vo);
  }

  @Override
  public Integer sendMms(MessageVO vo) throws Exception {
    return messageDAO.sendMms(vo);
  }

  @Override
  public void sendMms(List<MessageVO> list) throws Exception {
    messageDAO.sendMms(list);
  }

}
