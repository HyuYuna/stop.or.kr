package egovframework.plani.template.cmm.dao;

import java.sql.SQLException;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.ibatis.sqlmap.client.SqlMapExecutor;
import egovframework.plani.template.cmm.vo.MessageVO;
import egovframework.rte.psl.orm.ibatis.SqlMapClientCallback;

@Repository("messageDAO")
public class MessageDAO extends EgovComAbstractDAO {

  public Integer sendSms(MessageVO vo) throws Exception {
    System.out.println("11111111111");
    return (Integer) insert("messageDAO.insertSms", vo);
  }

  public Integer sendMms(MessageVO vo) {
    return (Integer) insert("messageDAO.insertMms", vo);
  }

  @SuppressWarnings("unchecked")
  public void sendMms(final List<MessageVO> vo) {
    getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
      @Override
      public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
        for (MessageVO m : vo) {
          executor.insert("messageDAO.insertMms", m);
        }
        executor.executeBatch();
        return null;
      }
    });
  }
}
