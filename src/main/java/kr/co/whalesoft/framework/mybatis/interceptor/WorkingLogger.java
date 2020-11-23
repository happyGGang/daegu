package kr.co.whalesoft.framework.mybatis.interceptor;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author whalesoft
 * @date 2020.08.28
 *
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface WorkingLogger {

	/**
	 * 로그구분. P:개인정보, W:일반작업
	 * <p>default "W"<p>
	 */
	public String type() default "W";

	/**
	 * 작업 내용. DML(CRUD) 내용
	 * <p>default "일반작업"</p>
	 */
	public String comment() default "일반작업";
}
