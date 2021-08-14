package com.example.sproject.model.mail;

import lombok.Data;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
public class MailTo {
	@NonNull
	int ml_num;
	@NonNull
	String ml_email;
	int mlt_type;
	int mlt_status;
}
