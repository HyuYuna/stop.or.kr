package egovframework.plani.template.cmm.exceptions;

import java.text.MessageFormat;
import egovframework.rte.fdl.cmmn.exception.BaseException;

public class CmmnException extends BaseException {

  private static final long serialVersionUID = 6577860036916832087L;
  private boolean useReferer = false;

  public CmmnException() {
    this("CmmnException without message", null, null);
  }


  public CmmnException(String defaultMessage) {
    this("CMMN : " + defaultMessage, null, null);
  }

  public CmmnException(String defaultMessage, boolean useReferer) {
    this(defaultMessage, null, null);
    this.setUseReferer(useReferer);
  }

  public CmmnException(String defaultMessage, Object[] messageParameters,
      Exception wrappedException) {
    String userMessage = defaultMessage;
    if (messageParameters != null) {
      userMessage = MessageFormat.format(defaultMessage, messageParameters);
    }
    this.message = userMessage;
    this.wrappedException = wrappedException;
  }


  public void setUseReferer(boolean useReferer) {
    this.useReferer = useReferer;
  }


  public boolean isUseReferer() {
    return useReferer;
  }
}
