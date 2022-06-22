package com.mydiary.quartz;

import java.util.HashMap;

import javax.annotation.PostConstruct;

import org.hibernate.mapping.Map;
import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class QuartzConfig {
	private SchedulerFactory factory;
	private Scheduler scheduler;
	
	@PostConstruct
	public void start() throws SchedulerException{
		factory = new StdSchedulerFactory();
		scheduler = factory.getScheduler();
		scheduler.start();
		
		JobDetail sendemail = JobBuilder.newJob(QuartzJob.class).build();
		
		Trigger emailTrigger = TriggerBuilder.newTrigger().withIdentity(new TriggerKey("sendemailKey"))
				.withSchedule(CronScheduleBuilder.cronSchedule("0 0 21 1/1 * ? *")).build(); // 매일 오후 6시 20분 메세지
				//.withSchedule(CronScheduleBuilder.cronSchedule("0 0/1 * 1/1 * ? *")).build(); // 1분마다 유발
		
		scheduler.scheduleJob(sendemail, emailTrigger);
				
	}
	
}