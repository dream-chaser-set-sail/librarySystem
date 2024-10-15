package Util;

import java.text.SimpleDateFormat;
import java.util.*;

public class ComputingTimeUtil {
    public static String extensionOfvalidity(Date date, Integer dayCount){
        Map<Integer, Integer> dayMonth = new HashMap<>();
        String result = "";
        // 奇术月份
        Integer oddMonth[] = {1, 3, 5, 7, 8, 10, 12};
        for (Integer odd : oddMonth) {
            dayMonth.put(odd,31);
        }

        // 偶数月份
        Integer evenMonth[] = {4, 6, 9, 11};
        for (Integer even : evenMonth) {
            dayMonth.put(even,30);
        }

        // 将时间戳转为字符串
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDate = formatter.format(date);

        // 拆分日期
        String[] split = formattedDate.split(" ");
        String Date = split[0];
        String Time = split[1];

        // 拆分年月日
        String[] YTD = Date.split("-");
        Integer nowYear = Integer.valueOf(YTD[0]);
        Integer nowMonth = Integer.valueOf(YTD[1]);
        Integer nowDay = Integer.valueOf(YTD[2]);

        // 判断年份(闰 or 平)
        if ((nowYear % 4 == 0 && nowYear % 100 != 0) || (nowYear % 400 == 0)) {
//            System.out.println("闰年");
            dayMonth.put(2,29);
        } else {
//            System.out.println("平年");
            dayMonth.put(2,28);
        }

        if ((nowDay + dayCount) <= dayMonth.get(nowMonth)){
            result = nowYear+"-"+nowMonth+"-"+(nowDay + dayCount)+" "+Time;
        }else {
            int sum = nowDay + dayCount;
            String calculate = calculate(sum, nowYear, nowMonth, dayMonth);
            result = calculate+" "+Time;
        }
        return result;
    }

    public static String calculate(Integer sum, Integer nowYear, Integer nowMonth, Map<Integer, Integer> dayMonth){
        Integer Month = nowMonth;
        Integer Day = null;

        // 计算到期日期
//        ===============超过本月, 未超过下月================
        if (nowMonth != 0 && nowMonth > 12) { // 保证不会超过12月, 超出部分回到下年1月
            nowYear += 1;
            nowMonth = 1;
        } else {
            if (sum > dayMonth.get(nowMonth)) {
                int nextDay = sum - dayMonth.get(nowMonth);
                Day = nextDay;
                Month = nowMonth+1;

//        ===============超过本月, 也超过下月================
                if (nextDay > dayMonth.get(nowMonth + 1)) {
                    nowMonth += 1;
                    return calculate(nextDay, nowYear, nowMonth, dayMonth);
                }
            }
        }
        String result = nowYear+"-"+Month+"-"+Day;
        return result;
    }




    // 日期转当年天数

    public static Integer DatechangeTime(Date date){
        /*==================== 局部变量定义 ====================*/

        // 存储月份和月份对应的天数
        Map<Integer, Integer> dayMonth = new HashMap<>();

        // 判断年份 0 闰 1 平
        Integer particularYear = null;

        // 天数
        Integer dayCount = null;

        // 奇术月份
        Integer oddMonth[] = {1, 3, 5, 7, 8, 10, 12};
        for (Integer odd : oddMonth) {
            dayMonth.put(odd,31);
        }

        // 偶数月份
        Integer evenMonth[] = {4, 6, 9, 11};
        for (Integer even : evenMonth) {
            dayMonth.put(even,30);
        }


        /*==================== 方法 ====================*/
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedDate = formatter.format(date);

        // 拆分日期
        String[] split = formattedDate.split(" ");
        String nowDate = split[0];

        // 拆分年月日
        String[] YTD = nowDate.split("-");
        Integer nowYear = Integer.valueOf(YTD[0]);
        Integer nowMonth = Integer.valueOf(YTD[1]);
        Integer nowDay = Integer.valueOf(YTD[2]);

        // 判断年份(闰 or 平)
        if ((nowYear % 4 == 0 && nowYear % 100 != 0) || (nowYear % 400 == 0)) {
//            System.out.println("闰年");
            particularYear = 0;
        } else {
//            System.out.println("平年");
            particularYear = 1;
        }

        // 根据年份决定天数
        if (particularYear == 0){
            // 确定年份的2月
            dayMonth.put(2,29);
        }else if (particularYear == 1){
            // 确定年份的2月
            dayMonth.put(2,28);
        }

        // 根据月份和日期判断当前日期是当前年的第几天
        Integer days = 0;
        for (Map.Entry<Integer, Integer> entry : dayMonth.entrySet()) {
            if (nowMonth >= entry.getKey()){
                days += entry.getValue();
//                System.out.println("月份: " + entry.getKey() + ", 天数: " + entry.getValue());
            }
        }
        int surplus = dayMonth.get(nowMonth) - nowDay;
        dayCount = days - surplus;

        return dayCount;
    }
}
