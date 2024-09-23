package io.good.gooddev_web.member.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import io.good.gooddev_web.member.dto.MemberDTO;

@Mapper
public interface MemberDAO { 
    void insertMember(MemberDTO member); //회원가입
    MemberDTO selectMemberById(String mid); //회원 상세조회
    List<MemberDTO> selectAllMembers(); //모든 회원정보 조회
    void updateMember(MemberDTO member); //회원정보 수정
    void deleteMember(String mid); //회원탈퇴
}
