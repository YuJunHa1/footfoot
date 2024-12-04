package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.UserDAO;
import footfoot.model.User;

public class JoinActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");

        // 파라미터 가져오기
        String user_id = request.getParameter("user_id");
        String user_password = request.getParameter("user_password");
        String user_password2 = request.getParameter("user_password2");
        String user_name = request.getParameter("user_name");
        String birthdate = request.getParameter("birthdate");
        String gender = request.getParameter("gender");

        // 비밀번호 확인
        if (!user_password.equals(user_password2)) {
            request.setAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
            return "join";
        }

        // User 객체 생성
        User user = new User();
        user.setUser_id(user_id);
        user.setUser_password(user_password);
        user.setUser_name(user_name);
        user.setBirthdate(birthdate);
        user.setGender(gender);

        // 회원가입 처리
        UserDAO userDAO = new UserDAO();
        int result = userDAO.join(user);
        if (result == -1) {
            request.setAttribute("errorMsg", "이미 존재하는 아이디입니다.");
            return "join";
        }

        // 회원가입 성공
        request.setAttribute("successMsg", "회원가입이 완료되었습니다.");
        return "login"; // login.jsp로 이동
    }
}