package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LogoutActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 세션 무효화
        request.getSession().invalidate();

        // 메인 페이지로 리다이렉트
        return "main";
    }
}