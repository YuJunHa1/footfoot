package footfoot.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import footfoot.DAO.PostDAO;
import footfoot.model.Post;

public class WriteActionHandler implements CommandHandler {
    @Override
    public String process(HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 한글 깨짐 방지를 위한 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");

        // 세션에서 사용자 ID 가져오기
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        // 로그인이 되어 있지 않다면 로그인 페이지로 리다이렉트
        if (user_id == null) {
            request.setAttribute("errorMsg", "로그인 후에 이용하세요.");
            return "login"; // login.jsp로 포워딩
        }

        // 요청 파라미터로 제목과 내용 가져오기
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // Post 객체 생성 및 데이터 설정
        Post post = new Post();
        post.setUser_id(user_id);
        post.setPost_type("free"); // 글 유형을 "free"로 설정
        post.setTitle(title);
        post.setContent(content);

        // PostDAO를 이용하여 글 저장
        PostDAO postDAO = new PostDAO();
        int result = postDAO.write(post);

        if (result == -1) { // 글쓰기 실패
            request.setAttribute("errorMsg", "글쓰기에 실패했습니다.");
            return "write"; // 다시 글쓰기 페이지로 포워딩
        }

        // 글쓰기 성공 시 게시글 목록 페이지로 이동
        return "post"; // post.jsp로 포워딩
    }
}