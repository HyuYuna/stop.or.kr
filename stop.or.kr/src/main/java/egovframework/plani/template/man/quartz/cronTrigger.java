package egovframework.plani.template.man.quartz;

import java.text.SimpleDateFormat;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.quartz.QuartzJobBean;
import egovframework.plani.template.cmm.service.MessageService;

public class cronTrigger extends QuartzJobBean {

  ApplicationContext ctx;

  @Override
  protected void executeInternal(JobExecutionContext context) throws JobExecutionException {

    long time = System.currentTimeMillis();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    System.out.println("Cron trigger 1 (5 second): current time = " + sdf.format(time));

    /***********************************************************
     * TODO : 스케줄러 반복할 내용 처리 Start
     ***********************************************************/

    try {
      ctx = (ApplicationContext) context.getJobDetail().getJobDataMap().get("applicationContext");
      MessageService messageService = (MessageService) ctx.getBean("messageService");

      /*
       * MessageVO msgVO = new MessageVO( "01055468774",
       * "<태권도원> 예약신청 접수 완료 - 예약(예약번호:[]) 신청이 접수되었습니다. 2시간 이내 결제를 완료해 주세요.(2시간이 지나면 자동으로 취소됩니다.)",
       * "0633200114"); messageService.sendSms(msgVO);
       */

    } catch (Exception e) {
      e.printStackTrace();
    }

    /***********************************************************
     * TODO : 스케줄러 반복할 내용 처리End
     ***********************************************************/
  }

}
