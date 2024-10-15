package Util;

import Bean.BorrowTask;

import java.util.Map;
import java.util.concurrent.*;

public class ScheduledTask {
    // 创建一个定时任务调度器
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
    // 存储借书任务的线程安全集合
    private final Map<String, BorrowTask> borrowTasks = new ConcurrentHashMap<>();

    // 安排借书任务
    public String scheduleBorrowTask(String uid, String isbn, long endTime) {
        String ok = "";
        // 计算到还书时间的延迟
        long delay = endTime - System.currentTimeMillis(); // endTime是毫秒数 System.currentTimeMillis()是获取当前时间的毫秒数
        if (delay > 0) { // 如果延迟大于0，说明还书时间在未来
            // 将任务存入Map中
            borrowTasks.put(isbn, new BorrowTask(uid, isbn, endTime));
            // 安排一个定时任务，延迟到达时调用发送提醒的方法
            ok = String.valueOf(scheduler.schedule(() -> sendReminder(isbn), delay, TimeUnit.MILLISECONDS));// 到达相应时间才会执行这个sendReminder()方法
        }
        return ok;
    }

    // 发送还书提醒
    private String sendReminder(String isbn) {
        String ok = "";
        // 从Map中获取并移除对应的任务
        BorrowTask task = borrowTasks.remove(isbn);
        if (task != null) { // 如果找到了任务
            System.out.println("Reminder: User " + task.getUid() + ", please return the book with ISBN: " + task.getIsbn() + ".");
            ok = "Reminder: User " + task.getUid() + ", please return the book with ISBN: " + task.getIsbn() + ".";
        }
        return ok;
    }

    // 关闭调度器
    public void shutdown() {
        scheduler.shutdown();
    }
}
