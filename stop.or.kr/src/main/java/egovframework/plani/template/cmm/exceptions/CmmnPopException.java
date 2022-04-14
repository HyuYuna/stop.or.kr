package egovframework.plani.template.cmm.exceptions;

import java.text.MessageFormat;
import egovframework.rte.fdl.cmmn.exception.BaseException;

public class CmmnPopException extends BaseException {

  private static final long serialVersionUID = 6577860036916832087L;
  private boolean useReferer = false;

  public CmmnPopException() {
    this("CmmnPopException without message", null, null);
  }


  public CmmnPopException(String defaultMessage) {
    this("CMMN : " + defaultMessage, null, null);
  }

  public CmmnPopException(String defaultMessage, boolean useReferer) {
    this(defaultMessage, null, null);
    this.setUseReferer(useReferer);
  }

  public CmmnPopException(String defaultMessage, Object[] messageParameters,
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
