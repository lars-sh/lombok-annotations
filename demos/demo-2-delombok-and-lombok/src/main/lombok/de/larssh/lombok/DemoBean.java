package de.larssh.lombok;

import lombok.Data;
import lombok.experimental.NonFinal;

@Data
public class DemoBean {
	@NonFinal
	String demoField;

	public void setDemoField(final String demoVariable) {
		demoField = demoVariable;
	}
}
