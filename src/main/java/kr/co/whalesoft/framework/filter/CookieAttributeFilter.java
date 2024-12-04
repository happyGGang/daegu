package kr.co.whalesoft.framework.filter;


import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CookieAttributeFilter implements Filter {

    @SuppressWarnings("unused")
    private FilterConfig config;

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        res.setHeader("Set-Cookie", "locale=pt-BR; HttpOnly; Secure; SameSite=Strict;");
        chain.doFilter(req, res);
    }

    public void init(FilterConfig config) throws ServletException {
        this.config = config;
    }

    public void destroy() {

    }
}
