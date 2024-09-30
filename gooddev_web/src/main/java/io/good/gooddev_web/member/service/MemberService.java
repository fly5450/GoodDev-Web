package io.good.gooddev_web.member.service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import io.good.gooddev_web.member.dao.MemberDAO;
import io.good.gooddev_web.member.dto.MemberDTO;
import io.good.gooddev_web.member.vo.MemberVO;
import io.good.gooddev_web.search.dto.PageRequestDTO;
import io.good.gooddev_web.search.dto.PageResponseDTO;
import io.good.gooddev_web.util.MapperUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberService {

    private final MapperUtil mapperUtil;
    private final MemberDAO memberDAO;

    //모든 회원정보 출력
    public PageResponseDTO<MemberDTO> getList(PageRequestDTO pageRequestDTO) {
      List<MemberDTO> list = memberDAO.getList(pageRequestDTO)
          .stream()
          .map(member -> mapperUtil.map(member, MemberDTO.class))
          .collect(Collectors.toList());

      return new PageResponseDTO<>(pageRequestDTO, list, memberDAO.getTotalCount(pageRequestDTO));
    }
    
    public MemberDTO getRead(String mid) {
      return memberDAO.getReadMember_Optional(mid)
          .map(member -> mapperUtil.map(member, MemberDTO.class))
          .orElse(null);
    }
    
    //회원 탈퇴
    public int removeMember(String mid) {
      return memberDAO.removeMember(mid);
    }
    // 회원정보 수정
    public int modifyMemberInfo(MemberVO modifyMember) {
        MemberVO currentMember = memberDAO.getReadMember_Optional(modifyMember.getMid()).orElse(null);
        
        if (currentMember != null) {
            updateMemberFields(currentMember, modifyMember);
            int result = memberDAO.modifyMember(currentMember);
            log.info("회원정보 수정: ID = {}, 결과 = {}", modifyMember.getMid(), result);
            return result;
        }
        log.warn("회원정보 수정 실패: 존재하지 않는 회원 ID = {}", modifyMember.getMid());
        return 0;
    }

    /**
     * 회원 정보 필드를 업데이트합니다.
     * @param currentMember 현재 회원 정보
     * @param modifyMember 수정할 회원 정보
     */
    private void updateMemberFields(MemberVO currentMember, MemberVO modifyMember) {
        if (modifyMember.getPassword() != null) currentMember.setPassword(modifyMember.getPassword());
        if (modifyMember.getMember_name() != null) currentMember.setMember_name(modifyMember.getMember_name());
        if (modifyMember.getNickname() != null) currentMember.setNickname(modifyMember.getNickname());
        if (modifyMember.getPhone() != null) currentMember.setPhone(modifyMember.getPhone());
        if (modifyMember.getEmail() != null) currentMember.setEmail(modifyMember.getEmail());
    }

    /**
     * 새 회원을 등록합니다.
     * @param member 등록할 회원 정보
     * @return 처리 결과 (성공: 1, 실패: 0)
     */
    public int registerMember(final MemberVO member) {
        int result = memberDAO.registerMember(member);
        log.info("회원가입 처리: ID = {}, 결과 = {}", member.getMid(), result);
        return result;
    }

    /**
     * 이메일로 회원 ID를 찾습니다.
     * @param email 이메일 주소
     * @return 찾은 회원 ID, 없으면 null
     */
    public String findIdByEmail(String email) {
        String foundId = memberDAO.findIdByEmail(email);
        log.info("아이디 찾기: 이메일 = {}, 결과 = {}", email, foundId != null ? "성공" : "실패");
        return foundId;
    }

    /**
     * 비밀번호를 재설정합니다.
     * @param mid 회원 ID
     * @param email 이메일 주소
     * @param newPassword 새 비밀번호
     * @return 처리 결과 (성공: true, 실패: false)
     */
    public boolean findPwd(String mid, String email, String newPassword) {
        if (memberDAO.validateUser(mid, email)) {
            MemberVO member = memberDAO.getReadMember_Optional(mid).orElse(null);
            if (member != null) {
                member.setPassword(newPassword);
                int result = memberDAO.modifyMember(member);
                log.info("비밀번호 재설정: ID = {}, 결과 = {}", mid, result > 0 ? "성공" : "실패");
                return result > 0;
            }
        }
        log.warn("비밀번호 재설정 실패: 유효하지 않은 사용자 ID = {}, 이메일 = {}", mid, email);
        return false;
    }

    /**
     * 사용자 유효성을 검증합니다.
     * @param mid 회원 ID
     * @param email 이메일 주소
     * @return 유효성 검증 결과
     */
    public boolean isUserValid(String mid, String email) {
        boolean isValid = memberDAO.validateUser(mid, email);
        log.debug("사용자 검증: ID = {}, 이메일 = {}, 결과 = {}", mid, email, isValid);
        return isValid;
    }
 
    public MemberDTO getRead_Auto_Login(String auto_Login) {
      MemberVO member = memberDAO.getRead_Auto_Login(auto_Login);
      if(member == null) return null;
      else return mapperUtil.map(member,MemberDTO.class);
    }

    public MemberDTO login(MemberVO inMember,String auto_login_check) {
      MemberVO member = memberDAO.getReadMember_Optional(inMember.getMid()).orElse(null);
      if (member != null && member.getPassword().equals(inMember.getPassword())) {
        if (auto_login_check.equals("on")) {
          String auto_Login = UUID.randomUUID().toString();
          member.setAuto_Login(auto_Login);
          memberDAO.modify_Auto_Login(member);
        } else {
          member.setAuto_Login("");
          memberDAO.modify_Auto_Login(member);
        }
        return mapperUtil.map(member, MemberDTO.class);
      }
		return null;

    }

    public int modify_Auto_Login(MemberVO modify_auto_login) {
        return memberDAO.modify_Auto_Login(modify_auto_login);
    }
}
