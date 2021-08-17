package com.example.sproject.model.time;


import lombok.Data;

@Data
public class Time {

   private int tm_num;
   private String m_id;
   private int tm_type;
   private String tm_sdate;
   private String tm_edate;
   private String tm_sdate_time;
   private String tm_edate_time;
   private String tm_sdate_date;
   private String tm_edate_date;
   private String tm_edate_day;
   
   private int cnt;
   private String date_cnt;
}