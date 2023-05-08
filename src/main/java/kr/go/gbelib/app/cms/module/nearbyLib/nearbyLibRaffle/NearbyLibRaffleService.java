package kr.go.gbelib.app.cms.module.nearbyLib.nearbyLibRaffle;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.whalesoft.app.cms.member.Member;
import kr.co.whalesoft.framework.base.BaseService;
import kr.co.whalesoft.framework.utils.StaticVariables;
import kr.go.gbelib.app.cms.module.nearbyLib.NearbyLib;

@Service
public class NearbyLibRaffleService extends BaseService {
	
	@Autowired
	private NearbyLibRaffleDao dao;
	
	public int getNearbyLibRaffleCount(NearbyLibRaffle nearbyLibRaffle) {
		return dao.getNearbyLibRaffleCount(nearbyLibRaffle);
	}

	public List<NearbyLibRaffle> getNearbyLibRaffleList(NearbyLibRaffle nearbyLibRaffle) {
		return dao.getNearbyLibRaffleList(nearbyLibRaffle);
	}

	public List<NearbyLibRaffle> getWinFromNearbyLib(NearbyLibRaffle nearbyLibRaffle) {
		List<NearbyLibRaffle> raffleList = dao.getToShuffleNearbyLibRaffleList(nearbyLibRaffle);
		nearbyLibRaffle.setRaffle_count(raffleList.size());
		Collections.shuffle(raffleList);
		
		List<NearbyLibRaffle> winnerList = new ArrayList<>();
		
		for(int i = 0; i < nearbyLibRaffle.getWin_count(); i++) {
			winnerList.add(i, raffleList.get(i));
		}
		
		return winnerList;
	}

	public int getToShuffleNearbyLibRaffleCount(NearbyLibRaffle nearbyLibRaffle, NearbyLib nearbyLib) throws ParseException {
		if (StringUtils.isEmpty(nearbyLib.getEnd_date()) && StringUtils.isEmpty(nearbyLibRaffle.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			nearbyLib.setStart_date(startDateFormat.format(now));
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			cal.add(Calendar.DATE, 1);
			
			nearbyLib.setEnd_date(endDateFormat.format(cal.getTime()));
			
			nearbyLibRaffle.setStart_date(startDateFormat.format(now));
			nearbyLibRaffle.setEnd_date(endDateFormat.format(cal.getTime()));
		}
		
		if(StringUtils.equals(nearbyLibRaffle.getStart_date(), nearbyLibRaffle.getEnd_date())) {
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date EndDate = endDateFormat.parse(nearbyLibRaffle.getEnd_date());
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(EndDate);
			cal.add(Calendar.DATE, 1);
			
			nearbyLibRaffle.setEnd_date(endDateFormat.format(cal.getTime()));
		}
		
		if(StringUtils.isNotEmpty(nearbyLibRaffle.getStart_date()) && StringUtils.isNotEmpty(nearbyLibRaffle.getEnd_date())) {
			nearbyLib.setStart_date(nearbyLibRaffle.getStart_date());
			nearbyLib.setEnd_date(nearbyLibRaffle.getEnd_date());
		}
		
		int count = dao.getToShuffleNearbyLibRaffleCount(nearbyLibRaffle);
		
		return count;
	}
	
	public List<NearbyLibRaffle> getDedupeReservation(NearbyLibRaffle nearbyLibRaffle, NearbyLib nearbyLib) throws ParseException {
		if (StringUtils.isEmpty(nearbyLib.getEnd_date()) && StringUtils.isEmpty(nearbyLibRaffle.getEnd_date())) {
			SimpleDateFormat startDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date now = new Date();
			nearbyLib.setStart_date(startDateFormat.format(now));
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(now);
			cal.add(Calendar.DATE, 1);
			
			nearbyLib.setEnd_date(endDateFormat.format(cal.getTime()));
			
			nearbyLibRaffle.setStart_date(startDateFormat.format(now));
			nearbyLibRaffle.setEnd_date(endDateFormat.format(cal.getTime()));
		}
		
		if(StringUtils.equals(nearbyLibRaffle.getStart_date(), nearbyLibRaffle.getEnd_date())) {
			SimpleDateFormat endDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date EndDate = endDateFormat.parse(nearbyLibRaffle.getEnd_date());
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(EndDate);
			cal.add(Calendar.DATE, 1);
			
			nearbyLibRaffle.setEnd_date(endDateFormat.format(cal.getTime()));
		}
		
		if(StringUtils.isNotEmpty(nearbyLibRaffle.getStart_date()) && StringUtils.isNotEmpty(nearbyLibRaffle.getEnd_date())) {
			nearbyLib.setStart_date(nearbyLibRaffle.getStart_date());
			nearbyLib.setEnd_date(nearbyLibRaffle.getEnd_date());
		}
		
		List<NearbyLibRaffle> nearbyLibRaffleList = dao.getToShuffleNearbyLibRaffleList(nearbyLibRaffle);
	
		return nearbyLibRaffleList;
	}

	public void saveWinnerList(List<NearbyLibRaffle> winnerList, HttpServletRequest request, NearbyLibRaffle nearbyLibRaffle) {
		HttpSession session = request.getSession();
		Member member = (Member)session.getAttribute(StaticVariables.MEMBER);
		
		int raffleIdx = dao.getRaffleIdx();
		nearbyLibRaffle.setRaffle_idx(raffleIdx);
		
		if(StringUtils.isEmpty(nearbyLibRaffle.getRaffle_name())) {
			String raffleName = nearbyLibRaffle.getStart_date() + " ~ " + nearbyLibRaffle.getEnd_date();
			nearbyLibRaffle.setRaffle_name(raffleName);
		}
		
		dao.saveRaffleSetting(nearbyLibRaffle);
		
		for(int i = 0; i < winnerList.size(); i++) {
			nearbyLibRaffle = winnerList.get(i);
			nearbyLibRaffle.setRaffle_idx(raffleIdx);
			nearbyLibRaffle.setAdd_id(member.getMember_id());
			dao.saveWinnerList(nearbyLibRaffle);
		}
	}

	public List<NearbyLibRaffle> getWinnerNearbyLibRaffle(NearbyLibRaffle nearbyLibRaffle) {
		return dao.getWinnerNearbyLibRaffle(nearbyLibRaffle);
	}

	public int deleteRaffle(NearbyLibRaffle nearbyLibRaffle) {
		dao.deleteRaffleSetting(nearbyLibRaffle);
		return dao.deleteRaffle(nearbyLibRaffle);
	}

	public List<NearbyLibRaffle> getNearbyLibRaffleExcelList(NearbyLibRaffle nearbyLibRaffle) {
		return dao.getNearbyLibRaffleExcelList(nearbyLibRaffle);
	}

}
