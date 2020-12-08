package com.dealight.service;

import javax.mail.MessagingException;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.dealight.domain.Email;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MailServiceImpl implements MailService{

	@Autowired
	private JavaMailSender javaMailSender;
	
	@Override
	public void send(Email email) {
		
		MimeMessage msg = javaMailSender.createMimeMessage();
		
		try {
			msg.setSubject(email.getTitle());
			msg.setText(email.getContent());
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email.getTo()));

		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		try {
			javaMailSender.send(msg);
		} catch (MailException e) {
			e.printStackTrace();
		}
		
	}
	

}
