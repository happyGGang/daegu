/**
 *
 */
package kr.co.whalesoft.framework.aop;

import java.lang.reflect.Field;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @author whaleesoft YONGJU 2019. 12. 3.
 *
 */
@Intercepts (@Signature (type = Executor.class, method = "query", args = {MappedStatement.class, Object.class, RowBounds.class, ResultHandler.class}))
public class QueryInterceptor implements Interceptor {

	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public Object intercept(Invocation invocation) throws Throwable {

//		Object[] args = invocation.getArgs();
//		MappedStatement ms = (MappedStatement) args[0];
//		Object param = (Object) args[1];
//		BoundSql boundSql = ms.getBoundSql(param);
//		String sql = boundSql.getSql();
//
//		try {
//			String[] methodPath = ms.getId().split("\\.");
//			String beanName = methodPath[methodPath.length-2];
//			beanName = beanName.substring(0,1).toLowerCase() + beanName.substring(1, beanName.length()-3) + "Service";
//			Class<? extends Object> clazz = BeanFinder.getBean(beanName).getClass();
//			String methodName = methodPath[methodPath.length-1];
//			Method method = clazz.getDeclaredMethod(methodName);
//			kr.co.whalesoft.framework.annotation.PrivacyLog annotation = method.getAnnotation(kr.co.whalesoft.framework.annotation.PrivacyLog.class);
//			if (annotation == null) {
//
//			}
//
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//
//		//select query pass
//		if (ms.getSqlCommandType() == SqlCommandType.SELECT) {
//			return invocation.proceed();
//		}
//
//		//로그기록 쿼리는 pass
//		if (StringUtils.contains(ms.getId(), "kr.co.whalesoft.app.cms.privacyLog.PrivacyLogDao")) {
//			return invocation.proceed();
//		}
//
//		//파라미터 있는 경우에만 맵핑
//		if (param != null) {
//			sql = getMappedQuery(param, boundSql, sql);
//		}
//
//		HttpServletRequest request = BeanFinder.getHttpServletRequest();
//		Member member = (Member) request.getSession().getAttribute(StaticVariables.MEMBER);
//
//		//익명유저 pass
//		if (member == null || !member.isLogin()) {
//			return invocation.proceed();
//		}
//
//		try {
//			PrivacyLogService bean = (PrivacyLogService) BeanFinder.getBean(PrivacyLogService.class);
//
//			if (bean != null) {
//				bean.addPrivacyLog(new PrivacyLog(sql, member.getMember_id(), request.getRemoteAddr()));
//			}
//		} catch (BeansException e) {
//			logger.error("Cannot Found PrivacyLogService.class");
//		} catch (Exception e) {
//			logger.error("Error");
//		}


		return invocation.proceed();
	}

	private String getMappedQuery(Object param, BoundSql boundSql, String sql) throws NoSuchFieldException, IllegalAccessException {
		if (param instanceof Integer || param instanceof Long || param instanceof Float || param instanceof Double) {
			sql = sql.replaceFirst("\\?", param.toString());
		} else if (param instanceof String) {
			sql = sql.replaceFirst("\\?", "'" + param + "'");
		} else if (param instanceof Map) {
			List<ParameterMapping> paramMapping = boundSql.getParameterMappings();
			for (ParameterMapping mapping : paramMapping) {
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
					sql = sql.replaceFirst("\\?", field.get(param).toString());
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
