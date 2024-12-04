package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.UserDAO;
import footfoot.model.User;

public class UpdateMyInfoHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 세션에서 사용자 ID 가져오기
        String userId = (String) request.getSession().getAttribute("user_id");
        if (userId == null) {
            request.setAttribute("errorMsg", "로그인 후 이용하세요.");
            return "login";
        }

        // 사용자 데이터 가져오기
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userId);
        if (user == null) {
            request.setAttribute("errorMsg", "사용자 정보를 불러올 수 없습니다.");
            return "main";
        }

        // 사용자 정보를 요청 속성에 설정
        request.setAttribute("user", user);

        return "updateMyInfo"; // updateMyInfo.jsp로 포워딩
    }
}