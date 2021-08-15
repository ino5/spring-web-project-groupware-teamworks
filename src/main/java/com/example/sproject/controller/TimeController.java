package com.example.sproject.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.sproject.model.address.Department;
import com.example.sproject.model.login.Member;
import com.example.sproject.model.time.Time;
import com.example.sproject.service.address.Paging;
import com.example.sproject.service.time.TimeService;

@Controller
@RequestMapping("time")
public class TimeController {
	
	@Autowired
	private TimeService times;
	
	@RequestMapping("")
	public String index(Principal principal, Model model) {
		System.out.println("TimeController Start index..." );
		String m_id = principal.getName();
		Time mainTime = times.mainTime(m_id);
		List<Time> timeList_sdate = times.timeList_sdate(m_id);
		List<Time> timeList_edate = times.timeList_edate(m_id);
		List<Department> listDeptGroup = times.listDeptGroup();
		model.addAttribute("mainTime", mainTime);
		model.addAttribute("timeList_sdate", timeList_sdate);
		model.addAttribute("timeList_edate", timeList_edate);
		model.addAttribute("listDeptGroup", listDeptGroup);
		return "time/time";
	}
	@RequestMapping("timeDept")
	public String timeDept(Principal principal, String dpt_code, Member member, String currentPage, Model model) {
		System.out.println("TimeController Start timeDept..." );
		int total = times.totalDept(dpt_code);
		String m_id = principal.getName();
		Time mainTime = times.mainTime(m_id);
		Paging pg = new Paging(total, currentPage);
		member.setStart(pg.getStart());   // 시작시 1
		member.setEnd(pg.getEnd());       // 시작시 10 
		List<Member> listDeptGroupMember = times.listDeptGroupMember(member);
		List<Department> listDeptGroup = times.listDeptGroup();
		List<Member> listDeptGroupTime = times.listDeptGroupTime(member);
		List<Time> timeList_sdate = times.timeList_sdate(m_id);
		List<Time> timeList_edate = times.timeList_edate(m_id);
		model.addAttribute("mainTime", mainTime);
		model.addAttribute("timeList_sdate", timeList_sdate);
		model.addAttribute("timeList_edate", timeList_edate);
		model.addAttribute("listDeptGroupMember", listDeptGroupMember);
		model.addAttribute("listDeptGroup", listDeptGroup);
		model.addAttribute("dpt_code", dpt_code);
		model.addAttribute("listDeptGroupTime", listDeptGroupTime);
		model.addAttribute("total", total); 
		model.addAttribute("pg",pg);
		return "time/timeDept";
	}
	
	@RequestMapping(value="startTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void startTime(Principal principal, Time time) {
		System.out.println("TimeController Start startTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		times.startTime(time);
		
	}
	
	@RequestMapping(value="endTime", method= {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public void endTime(Principal principal, Time time) {
		System.out.println("TimeController Start endTime..." );
		String m_id = principal.getName();
		time.setM_id(m_id);
		times.endTime(time);
	}
	
	@RequestMapping("123")
	public String asd() {
		System.out.println("TimeController Start timeDept..." );
		return "time/123";
	}
}
