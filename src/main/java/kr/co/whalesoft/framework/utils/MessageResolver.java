package kr.co.whalesoft.framework.utils;

import java.util.Locale;
import kr.co.whalesoft.framework.utils.MessageResolver;
import org.springframework.context.support.MessageSourceAccessor;

public class MessageResolver {
  private static MessageSourceAccessor msAcc = null;
  
  private static Locale locale = Locale.KOREAN;
  
  public void setMessageSourceAccessor(MessageSourceAccessor msAcc) {
    MessageResolver.msAcc = msAcc;
  }
  
  public String getMessage(Object ob, String key) {
    return msAcc.getMessage(String.valueOf(ob.toString().substring(0, ob.toString().indexOf("@"))) + "." + key, locale);
  }
  
  public String getMessage(Object ob, String key, Object obj) {
    Object[] objs = new Object[1];
    objs[0] = obj;
    return msAcc.getMessage(String.valueOf(ob.toString().substring(0, ob.toString().indexOf("@"))) + "." + key, objs, locale);
  }
  
  public String getMessage(Object ob, String key, Object[] objs) {
    return msAcc.getMessage(String.valueOf(ob.toString().substring(0, ob.toString().indexOf("@"))) + "." + key, objs, locale);
  }
  
  public String getMessage(String key) {
    return msAcc.getMessage(key, locale);
  }
  
  public String getMessage(String key, Object[] objs) {
    return msAcc.getMessage(key, objs, locale);
  }
}