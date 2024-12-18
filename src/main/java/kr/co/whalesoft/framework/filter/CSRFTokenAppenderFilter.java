package kr.co.whalesoft.framework.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

public class CSRFTokenAppenderFilter implements Filter {

    private static final String CSRF_TOKEN_SESSION_ATTRIBUTE = "CSRF_TOKEN";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();

        String csrfToken = (String) session.getAttribute(CSRF_TOKEN_SESSION_ATTRIBUTE);
        if (csrfToken == null) {
            csrfToken = UUID.randomUUID().toString();
            session.setAttribute(CSRF_TOKEN_SESSION_ATTRIBUTE, csrfToken);
        }

        String requestURI = httpRequest.getRequestURI();

        //독서퀴즈 csrf 필터제외
        if (requestURI.equals("/cms/module/quiz/editQuestion.do")) {
            chain.doFilter(request, response);
            return;
        }
//        System.out.println("Request URI: " + requestURI);

        CharResponseWrapper wrappedResponse = new CharResponseWrapper(httpResponse);

        chain.doFilter(request, wrappedResponse);

        String originalContent = wrappedResponse.toString();

        String modifiedContent = originalContent.replaceAll("(?i)(<form[^>]*method=['\"]?post['\"]?[^>]*>)", "$1\n<input type=\"hidden\" name=\"csrfToken\" value=\"" + csrfToken + "\">");

        ServletOutputStream out = response.getOutputStream();
        out.write(modifiedContent.getBytes());
        out.flush();
    }

    @Override
    public void destroy() {
    }
}
