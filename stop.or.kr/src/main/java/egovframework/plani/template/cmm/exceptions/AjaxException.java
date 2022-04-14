package egovframework.plani.template.cmm.exceptions;

import java.text.MessageFormat;
import egovframework.rte.fdl.cmmn.exception.BaseException;

public class AjaxException extends BaseException {

  private static final long serialVersionUID = 6577860036916832087L;

  public AjaxException() {
    this("AjaxException without message", null, null);
  }


  public AjaxException(String defaultMessage) {
    this(defaultMessage, null, null);
  }

  public AjaxException(String defaultMessage, Object[] messageParameters,
      Exception wrappedException) {
    String userMessage = defaultMessage;
    if (messageParameters != null) {
      userMessage = MessageFormat.format(defaultMessage, messageParameters);
    }
    this.message = userMessage;
    this.wrappedException = wrappedException;
  }
}
