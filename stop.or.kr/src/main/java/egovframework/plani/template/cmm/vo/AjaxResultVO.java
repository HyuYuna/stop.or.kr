package egovframework.plani.template.cmm.vo;

public class AjaxResultVO {
  private boolean error = true;
  private Object messages;
  private String url;
  private int id;
  private Object data;

  public Object getData() {
    return data;
  }

  public boolean isError() {
    return error;
  }

  public void setError(boolean error) {
    this.error = error;
  }

  public void setData(Object data) {
    this.data = data;
  }

  public String getUrl() {
    return url;
  }

  public void setUrl(String url) {
    this.url = url;
  }

  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public Object getMessages() {
    return messages;
  }

  public void setMessages(Object messages) {
    this.messages = messages;
  }


}
