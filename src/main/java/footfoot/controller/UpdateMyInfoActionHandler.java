package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import footfoot.DAO.UserDAO;
import footfoot.model.User;

public class UpdateMyInfoActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");

        // 세션에서 사용자 ID 확인
        String userId = (String) request.getSession().getAttribute("user_id");
        if (userId == null) {
            request.setAttribute("errorMsg", "로그인 후 이용하세요.");
            return "login";
        }

        // 사용자 입력 데이터 수집
        String userName = request.getParameter("user_name");
        String userPassword = request.getParameter("user_password");
        String userPassword2 = request.getParameter("user_password2");

        // 비밀번호 확인
        if (!userPassword.equals(userPassword2)) {
            request.setAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
            return "updateMyInfo";
        }

        // 사용자 정보 업데이트
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUser(userId);
        if (user == null) {
            request.setAttribute("errorMsg", "사용자 정보를 불러올 수 없습니다.");
            return "updateMyInfo";
        }

        user.setUser_name(userName);
        user.setUser_password(userPassword);

        int result = userDAO.update(user);

        if (result == -1) {
            request.setAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
            return "updateMyInfo";
        }

        // 성공 메시지 설정 및 메인 페이지로 이동
        request.setAttribute("successMsg", "회원정보가 성공적으로 수정되었습니다.");
        return "main";
    }
}