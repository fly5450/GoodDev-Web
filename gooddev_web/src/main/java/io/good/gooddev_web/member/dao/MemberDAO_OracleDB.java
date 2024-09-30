package io.good.gooddev_web.member.dao;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDAO_OracleDB implements MemberDAO {
    // Spring에서 MyBatis와 통합하기 위해 제공되는 클래스
    private final SqlSessionTemplate sqlSessionTemplate;

    // 전체 회원 목록 조회
    @Override
    public List<MemberVO> getList(PageRequestDTO pageRequestDTO) {
        // SQL 쿼리 실행 및 결과 반환
        return sqlSessionTemplate.selectList("io.good.gooddev_web.member.dao.MemberDAO.getList", pageRequestDTO);
    }

    // 특정 회원 조회 (Optional로 반환)
    @Override
    public Optional<MemberVO> getRead(String mid) {
        // 회원 ID로 회원 정보를 조회하고 Optional로 감싸서 반환
        return Optional.ofNullable(sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.getReadMember_Optional", mid));
    }

    // 회원 탈퇴 처리
    @Override
    public int remove(String mid) {
        // SQL 쿼리 실행하여 회원 탈퇴
        return sqlSessionTemplate.delete("io.good.gooddev_web.member.dao.MemberDAO.removeMember", mid);
    }

    // 회원 정보 수정
    @Override
    public int modify(MemberVO member) {
        // SQL 쿼리 실행하여 회원 정보 업데이트
        return sqlSessionTemplate.update("io.good.gooddev_web.member.dao.MemberDAO.modifyMember", member);
    }

    // 회원 가입 처리
    @Override
    public int register(MemberVO member) {
        // SQL 쿼리 실행하여 새 회원 등록
        return sqlSessionTemplate.insert("io.good.gooddev_web.member.dao.MemberDAO.registerMember", member);
    }

    // 전체 회원 수 조회
    @Override
    public int getTotalCount(PageRequestDTO pageRequestDTO) {
        // SQL 쿼리 실행하여 총 회원 수 반환
        return sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.getTotalCount", pageRequestDTO);
    }

    // 자동 로그인 처리
    @Override
    public MemberVO getRead_Auto_Login(String auto_Login) {
        // SQL 쿼리 실행하여 자동 로그인 회원 정보 조회
        return sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.getRead_Auto_Login", auto_Login);
    }

    // 자동 로그인 정보 수정
    @Override
    public int modify_Auto_Login(MemberVO modify_auto_login) {
        // SQL 쿼리 실행하여 자동 로그인 정보 업데이트
        return sqlSessionTemplate.update("io.good.gooddev_web.member.dao.MemberDAO.modify_Auto_Login", modify_auto_login);
    }

    // 로그인 처리
    @Override
    public MemberDTO getLogin(MemberDTO inMember) {
        // SQL 쿼리 실행하여 로그인 처리
        return sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.getLogin", inMember);
    }

    // 비밀번호 찾기 
    @Override
    public Boolean findPwdById(String mid, String email) {
        // mid와 email을 매개변수로 받아서 유효성 검증
        Map<String, String> params = Map.of("mid", mid, "email", email);
        Integer count = sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.findPwdById", params);
        return count != null && count > 0; //
    }
    
    // 아이디 찾기 
    @Override
    public String findIdByEmail(String email) {
        return sqlSessionTemplate.selectOne("Member.findIdByEmail", email);
    }

    @Override
    public Optional<MemberVO> getRead_uuid(String uuid) {
        return Optional.ofNullable(sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.getRead_uuid_Optional", uuid));
    }

    @Override
    public int modify_uuid(MemberVO modify_uuid) {
        return sqlSessionTemplate.update("io.good.gooddev_web.member.dao.MemberDAO.modify_uuid", modify_uuid);
    }

    @Override
    public Boolean validateUser(String mid, String email) {
        Map<String, String> params = Map.of("mid", mid, "email", email);
        Integer count = sqlSessionTemplate.selectOne("io.good.gooddev_web.member.dao.MemberDAO.validateUser", params);
        return count != null && count > 0;
    }
}