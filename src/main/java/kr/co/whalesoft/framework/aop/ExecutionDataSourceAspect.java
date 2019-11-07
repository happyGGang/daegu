package kr.co.whalesoft.framework.aop;
import java.lang.reflect.Method;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import kr.co.whalesoft.framework.dataSource.ContextHolder;
import kr.co.whalesoft.framework.dataSource.DataSource;
import kr.co.whalesoft.framework.dataSource.DataSourceType;
/**
* Order를 주는 이유는 다른 기타의 AOP 설정보다 DataSource 설정이 먼저 들어가게 하기 위해서이다.
*
* @author sidnancy81
*
*/
@Aspect
@Component
@Order(value=1)
public class ExecutionDataSourceAspect implements InitializingBean {
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	@Around("execution(* kr.co.whalesoft.app..*Service.*(..)) || execution(* kr.go.gbelib.app..*Service.*(..))")
	public Object doServiceProfiling(ProceedingJoinPoint joinPoint) throws Throwable {

		//Annotation을 읽어 들이기 위해 현재의 method를 읽어 들인다.
		final String methodName = joinPoint.getSignature().getName();
		final MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
		Method method = methodSignature.getMethod();
		if(method.getDeclaringClass().isInterface()) {
			method = joinPoint.getTarget().getClass().getDeclaredMethod(methodName, method.getParameterTypes());
		}
		
		DataSourceType prevDataSource = ContextHolder.getDataSourceType();
		Object returnValue = null;
		try {
			//Annotation을 가져온다.
			DataSource dataSource = (DataSource) method.getAnnotation(DataSource.class);
			if(dataSource != null) {
				//Method에 해당 dataSource관련 설정이 있을 경우 해당 dataSource의 value를 읽어 들인다.
				ContextHolder.setDataSourceType(dataSource.value());
			} else {
				//따로 annotation으로 datasource를 지정하지 않은 경우에는 메소드 이름으로 판단
				//get*, select* 의 경우는 default, 그 외의 경우에는 MASTER
				if(!(method.getName().startsWith("get") || method.getName().startsWith("select"))){
					ContextHolder.setDataSourceType(DataSourceType.MASTER);
				}
			}
			returnValue = joinPoint.proceed();
			ContextHolder.clearDataSourceType();
		} finally {
			if(prevDataSource != null) 	ContextHolder.setDataSourceType(prevDataSource);
		}
		
		return returnValue;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		// TODO Auto-generated method stub
		
	}
}