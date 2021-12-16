package kr.co.whalesoft.framework.mybatis.interceptor;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.app.cms.workingLog.WorkingLog;
import kr.co.whalesoft.app.cms.workingLog.WorkingLogService;
import kr.co.whalesoft.framework.utils.BeanFinder;
import kr.co.whalesoft.framework.utils.StaticVariables;
import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.mapping.ParameterMode;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/**
 * @author whalesoft
 * @date 2020.08.28
 *
 */
@Intercepts ({@Signature (type = Executor.class, method = "update", args = {MappedStatement.class, Object.class}), @Signature (type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class})})
public class QueryInterceptor implements Interceptor {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	private static String WORK_REASON = "work_reason";

	@Override
	public Object intercept(Invocation invocation) throws Throwable {
		Object proceed = null;
		if(RequestContextHolder.getRequestAttributes() != null) {
			HttpServletRequest request = BeanFinder.getHttpServletRequest();
			Member member = (Member) request.getSession().getAttribute(StaticVariables.MEMBER);
	
			// 익명유저 pass
			if (member == null || !member.isLogin()) {
				return invocation.proceed();
			}
	
			Object[] args = invocation.getArgs();
			MappedStatement ms = (MappedStatement) args[0];
	
			// 로그기록 쿼리는 pass
			if (StringUtils.contains(ms.getId(), "kr.co.whalesoft.app.cms.workingLog.WorkingLogDao")) {
				return invocation.proceed();
			}
	
			Object param = (Object) args[1];
			BoundSql boundSql = ms.getBoundSql(param);
			String sql = boundSql.getSql();
	
			try {
				String[] methodPath = ms.getId().split("\\.");
				String beanName = methodPath[methodPath.length - 2];
				beanName = ms.getId().substring(0, ms.getId().lastIndexOf(".") - 3) + "Service";
				// beanName = ms.getId().substring(0, ms.getId().lastIndexOf(".") );
				Class<?> clazz = Class.forName(beanName);
				String methodName = methodPath[methodPath.length - 1];
				Method[] methods = clazz.getDeclaredMethods();
				Method method = null;
				WorkingLogger annotation = null;
				for (Method m : methods) {
					if (methodName.equals(m.getName())) {
						annotation = (WorkingLogger) m.getAnnotation(WorkingLogger.class);
						if (annotation != null) {
							method = m;
							break;
						}
					}
				}
				if (method != null && annotation != null) {
	
					// 파라미터 있는 경우에만 맵핑
					if (param != null) {
						sql = getMappedQuery(param, boundSql, sql, ms);
					}
	
					try {
						WorkingLogService bean = (WorkingLogService) BeanFinder.getBean(WorkingLogService.class);
	
						if (bean != null) {
							int work_result_count = 0;
							proceed = invocation.proceed();
							if (proceed instanceof Integer || proceed instanceof Long || proceed instanceof Float || proceed instanceof Double || proceed instanceof String) {
								work_result_count = Integer.parseInt(proceed.toString());
							} else if (proceed instanceof ArrayList) {
								work_result_count = ((ArrayList<?>) proceed).size();
							}
							String asideHomepage_id = String.valueOf(request.getSession().getAttribute("asideHomepageId"));
							String work_reason = getWorkReason(param, boundSql);
							if ("NULL".equals(work_reason)) {
								work_reason = annotation.comment();
							}
							bean.addWorkingLog(new WorkingLog(asideHomepage_id, annotation.type(), annotation.comment(), ms.getSqlCommandType().toString(), sql, work_result_count, work_reason, member.getMember_id(), request.getRemoteAddr()));
						}
					} catch (BeansException e) {
						logger.error("Cannot Found WorkingLogService.class");
					} catch (Exception e) {
						logger.error("Error");
					}
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (proceed == null) {
					proceed = invocation.proceed();
				}
			}
		} else {
			proceed = invocation.proceed();
		}

		return proceed;
	}

	/**
	 * @author whalesoft
	 * @date 2020.09.02
	 *
	 * @param param
	 * @return
	 *
	 */
	private String getWorkReason(Object param, BoundSql boundSql) {
		if (param instanceof Integer || param instanceof Long || param instanceof Float || param instanceof Double || param instanceof String || param instanceof Map) {
			return null;
		}

		Class<? extends Object> paramClass = param.getClass();
		Class<? extends Object> superclass = paramClass.getSuperclass();

		Field field = null;
		// PagingUtils
		try {
			// BeanUtils
			Class<?> superSuperclass = superclass.getSuperclass();
			field = superSuperclass.getDeclaredField(WORK_REASON);
		} catch (NoSuchFieldException e) {
			// TODO Auto-generated catch block
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
		}
		if (field == null) {
			return "";
		}
		field.setAccessible(true);
		Object valueObject;
		String value = "NULL";
		try {
			valueObject = field.get(param);
			if (valueObject != null) {
				value = valueObject.toString();
			}
		} catch (IllegalArgumentException e1) {
			// TODO Auto-generated catch block
		} catch (IllegalAccessException e1) {
			// TODO Auto-generated catch block
		}

		return value;

	}

	private String getMappedQuery(Object param, BoundSql boundSql, String sql, MappedStatement ms) throws NoSuchFieldException, IllegalAccessException {
		if (param instanceof Integer || param instanceof Long || param instanceof Float || param instanceof Double) {
			sql = sql.replaceFirst("\\?", param.toString());
		} else if (param instanceof String) {
			sql = sql.replaceFirst("\\?", "'" + param + "'");
		} else if (param instanceof Map) {
			List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
			TypeHandlerRegistry typeHandlerRegistry = ms.getConfiguration().getTypeHandlerRegistry();
			Class<? extends Object> paramClass = param.getClass();
			for (ParameterMapping mapping : paramMapping) {
				if (mapping.getMode() != ParameterMode.OUT) {
					// ArrayList
					Object value;
					String propValue = mapping.getProperty();
					if (boundSql.hasAdditionalParameter(propValue)) {
						value = boundSql.getAdditionalParameter(propValue);
					} else if (paramClass == null) {
						value = null;
					} else if (typeHandlerRegistry.hasTypeHandler(paramClass.getClass())) {
						value = paramClass;
					} else {
						MetaObject metaObject = ms.getConfiguration().newMetaObject(paramClass);
						value = metaObject.getValue(propValue);
					}
					if (value == null) {
						continue;
					}
					if (value instanceof String) {
						sql = sql.replaceFirst("\\?", "'" + value + "'");
					} else {
						sql = sql.replaceFirst("\\?", value.toString());
					}
				} else {
					// Map
					String propValue = mapping.getProperty();
					@SuppressWarnings ("rawtypes")
					Object value = ((Map) param).get(propValue);
					if (value == null) {
						continue;
					}
					if (value instanceof String) {
						sql = sql.replaceFirst("\\?", "'" + value + "'");
					} else {
						sql = sql.replaceFirst("\\?", value.toString());
					}
				}

			}
		} else {
			List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
			Class<? extends Object> paramClass = param.getClass();
			Class<? extends Object> superclass = paramClass.getSuperclass();
			for (ParameterMapping mapping : paramMapping) {
				String propValue = mapping.getProperty();
				Field field = null;
				try {
					field = paramClass.getDeclaredField(propValue);
				} catch (Exception e) {
					try {
						// PagingUtils
						field = superclass.getDeclaredField(propValue);
					} catch (Exception e2) {
						// BeanUtils
						Class<?> superclass2 = superclass.getSuperclass();
						field = superclass2.getDeclaredField(propValue);
					}
				}
				field.setAccessible(true);
				Class<?> javaType = mapping.getJavaType();
				if (String.class == javaType) {
					sql = sql.replaceFirst("\\?", "'" + field.get(param) + "'");
				} else {
					Object valueObject = field.get(param);
					String value = "NULL";
					try {
						value = valueObject.toString();
					} catch (NullPointerException e) {} catch (Exception e) {}
					sql = sql.replaceFirst("\\?", "'" + value + "'");
					// sql = sql.replaceFirst("\\?", field.get(param).toString());
				}
			}
		}
		sql = sql.replaceAll("(\\t\\t)", "");
		return sql;
	}

	@Override
	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	@Override
	public void setProperties(Properties properties) {

	}
}
