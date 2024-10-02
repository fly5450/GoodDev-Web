package io.good.gooddev_web.member.service;

import java.util.List;
import java.util.Optional;
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
    // 회원 정보조회
    public MemberDTO getRead(String mid) {
      return memberDAO.getRead(mid)
          .map(member -> mapperUtil.map(member, MemberDTO.class))
          .orElse(null);
    }

    //회원 탈퇴
    public int remove(String mid) {
      return memberDAO.remove(mid);
    }
    // 회원정보 수정
    public int modifyMemberInfo(MemberVO modifyMember) {
        MemberVO currentMember = memberDAO.getRead(modifyMember.getMid()).orElse(null);
        
        if (currentMember != null) {
            updateMemberFields(currentMember, modifyMember);
            int result = memberDAO.modify(currentMember);
            log.info("회원정보 수정: ID = {}, 결과 = {}", modifyMember.getMid(), result);
            return result;
        }
        log.warn("회원정보 수정 실패: 존재하지 않는 회원 ID = {}", modifyMember.getMid());
        return 0;
    }

     // 회원정보 수정 -> 회원 정보 필드를 업데이트
    private void updateMemberFields(MemberVO currentMember, MemberVO modifyMember) {
        if (modifyMember.getPassword() != null) currentMember.setPassword(modifyMember.getPassword());
        if (modifyMember.getMember_name() != null) currentMember.setMember_name(modifyMember.getMember_name());
        if (modifyMember.getNickname() != null) currentMember.setNickname(modifyMember.getNickname());
        if (modifyMember.getPhone() != null) currentMember.setPhone(modifyMember.getPhone());
        if (modifyMember.getEmail() != null) currentMember.setEmail(modifyMember.getEmail());
    }

  // 새 회원을 등록합니다.
  public int register(final MemberVO member) {
      // 유효성 검증 추가
      if (!isValidRegisterMember(member)) {
          log.warn("회원가입 실패: 유효하지 않은 회원 정보 = {}", member);
          return 0;
      }
      int result = memberDAO.register(member);
  
      if (result > 0) {
          log.info("회원가입 처리: ID = {}, 결과 = {}", member.getMid(), result);
      } else {
          log.warn("회원가입 실패: ID = {}", member.getMid());
      }
      return result;
  }
  
  // 회원 정보 유효성 검사 메소드
  private boolean isValidRegisterMember(MemberVO member) {
      return member != null // 존재할 경우
          && isNotBlank(member.getMid())          //공백 체크
          && isNotBlank(member.getPassword())
          && isNotBlank(member.getMember_name())
          && isNotBlank(member.getEmail())
          && isEmailValid(member.getEmail())
          && !checkIdDuplicate(member.getMid()); // ID중복체크
  }
  
  // 문자열이 null이 아니고 비어있지 않은지 확인하는 헬퍼 메소드
  private boolean isNotBlank(String str) {
      return str != null && !str.trim().isEmpty();
  }
    
    // 이메일로 아이디 찾기
    public String findIdByEmail(String email) {
      Optional<MemberVO> member = memberDAO.findIdByEmail(email);
      if (member.isPresent()) {
          log.info("아이디 찾기 성공: 이메일 = {}, 아이디 = {}", email, member.get().getMid());
          return member.get().getMid();
      } else {
          log.info("아이디 찾기 실패: 이메일 = {}", email);
          return null;
      }
  }

    //아이디 중복 체크
  public boolean checkIdDuplicate(String mid) {
    return memberDAO.getRead(mid).isPresent(); // 아이디가 존재하면 Treu, 없으면 False 리턴
  } 
  //   public boolean isIdDuplicate(String mid) {
  //     return memberDAO.checkIdDuplicate(mid) > 0;
  // }
    // 아이디 정규식 검사
    public boolean isIdValid(String mid) {
        return memberDAO.IdValidatorREGEX(mid);
    }

  //이메일 중복 체크
  public boolean checkEmailDuplicate(String email){
    return memberDAO.getRead(email).isPresent(); //이메일이 존재하면 Treu, 없으면 False 리턴
    
  }
  //이메일 정규식 검사
  public boolean isEmailValid(String email) {
      return memberDAO.emailValidatorREGEX(email);
  }
    
    //비밀번호찾기
  public int findPassword(String mid,String email,String newPassword) {
      // 이메일로 검증
      Optional<MemberVO> member= memberDAO.getRead(mid);
      if(member.isPresent()){
        MemberVO modifyMember = member.get();
        if(modifyMember.getEmail().equals(email)){
          modifyMember.setPassword(newPassword);
          return memberDAO.modify(modifyMember);
        }
        else return -1;
      }
      else return -1;
  }
    //비밀번호 재설정
    public int resetPassword(String newPassword) {
       return memberDAO.resetPassword(newPassword);
    }

    
    public MemberDTO getRead_Auto_Login(String auto_Login) {
      MemberVO member = memberDAO.getRead_Auto_Login(auto_Login);
      if(member == null) return null;
      else return mapperUtil.map(member,MemberDTO.class);
    }

    public MemberDTO login(MemberVO inMember,String auto_login_check) {
      MemberVO member = memberDAO.getRead(inMember.getMid()).orElse(null);
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
    
    //마이페이지 회원정보 출력
    public MemberDTO getMemberInfo(String mid) {
        return memberDAO.getRead(mid)
            .map(member -> mapperUtil.map(member, MemberDTO.class))
            .orElse(null);
    }
}
