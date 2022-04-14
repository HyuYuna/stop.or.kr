package egovframework.plani.template.cmm.exceptions;

import java.text.MessageFormat;
import egovframework.rte.fdl.cmmn.exception.BaseException;

public class XSSException extends BaseException {
  private static final long serialVersionUID = 7577860036916832087L;
  private String field;

  public XSSException() {
    this("AjaxException without message", null, null);
  }

  public XSSException(String defaultMessage) {
    this(defaultMessage, null, null);
  }

  public XSSException(String defaultMessage, String field) {
    this(defaultMessage, null, null);
    this.field = field;
  }

  public XSSException(String defaultMessage, Object[] messageParameters,
      Exception wrappedException) {
    String userMessage = defaultMessage;
    if (messageParameters != null) {
      userMessage = MessageFormat.format(defaultMessage, messageParameters);
    }
    this.message = userMessage;
    this.wrappedException = wrappedException;
  }

  public String getField() {
    return field;
  }
}
