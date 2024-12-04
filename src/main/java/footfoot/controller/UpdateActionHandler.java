package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import footfoot.DAO.PostDAO;

public class UpdateActionHandler implements CommandHandler {

    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	request.setCharacterEncoding("UTF-8");

        // 세션에서 사용자 ID 가져오기
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        if (user_id == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login"; // login.jsp로 포워딩
        }

        // 게시글 ID 가져오기
        int post_id = 0;
        if (request.getParameter("post_id") != null) {
            post_id = Integer.parseInt(request.getParameter("post_id"));
        }

        if (post_id == 0) {
            request.setAttribute("errorMsg", "유효하지 않은 글입니다.");
            return "post"; // post.jsp로 포워딩
        }

        // 제목과 내용 가져오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // 유효성 검사
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMsg", "제목은 필수 입력 값입니다.");
            return "update"; // update.jsp로 다시 이동
        }

        if (content == null || content.trim().isEmpty()) {
            request.setAttribute("errorMsg", "내용은 필수 입력 값입니다.");
            return "update"; // update.jsp로 다시 이동
        }

        // 게시글 업데이트
        PostDAO postDAO = new PostDAO();
        int result = postDAO.update(post_id, title, content);

        if (result == -1) {
            request.setAttribute("errorMsg", "글 수정에 실패했습니다.");
            return "update"; // update.jsp로 다시 이동
        }

        // 성공 시 목록 페이지로 이동
        response.sendRedirect("post.do");
        return null; // 리다이렉트 시 JSP 반환하지 않음
    }
}