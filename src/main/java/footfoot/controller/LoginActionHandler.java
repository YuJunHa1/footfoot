package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import footfoot.DAO.UserDAO;
import footfoot.model.User;

public class LoginActionHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 요청 파라미터 가져오기
        String user_id = request.getParameter("user_id");
        String user_password = request.getParameter("user_password");

        UserDAO userDAO = new UserDAO();
        int loginResult = userDAO.login(user_id, user_password);

        if (loginResult == 1) { // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("user_id", user_id);

            // 사용자 이름 추가로 세션에 저장
            User user = userDAO.getUser(user_id); // User 객체 가져오기
            if (user != null) {
                session.setAttribute("user_name", user.getUser_name());
            }

            return "main"; // main.jsp로 포워딩
        } else if (loginResult == 0) { // 비밀번호 틀림
            request.setAttribute("errorMsg", "비밀번호가 틀렸습니다.");
            return "login"; // login.jsp로 포워딩
        } else if (loginResult == -1) { // 아이디 없음
            request.setAttribute("errorMsg", "존재하지 않는 아이디입니다.");
            return "login"; // login.jsp로 포워딩
        } else { // 데이터베이스 오류
            request.setAttribute("errorMsg", "데이터베이스 오류가 발생했습니다.");
            return "login"; // login.jsp로 포워딩
        }
    }
}
