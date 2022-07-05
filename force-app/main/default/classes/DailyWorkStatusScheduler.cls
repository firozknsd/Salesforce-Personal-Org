public class DailyWorkStatusScheduler implements System.Schedulable {
    public void execute(SchedulableContext sC) {
        new DailyWorkStatusController().sendMail();
    }
}