package com.ssi.sys.tags;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import org.apache.commons.lang.ObjectUtils;
import com.ssi.util.NumberToCN;
public class Number2CnTag extends SimpleTagSupport {
	private double value;
	public double getValue() {
		return value;
	}
	public void setValue(double value) {
		this.value = value;
	}
	public void doTag() throws JspException, IOException {
		  BigDecimal numberOfMoney = new BigDecimal(value);
		String val = NumberToCN.number2CNMontrayUnit(numberOfMoney);
		
		getJspContext().getOut().write(val);
	}

	public static String format(String value) {
		String val = ObjectUtils.toString(value, "");
		val = val.replaceFirst("^0*", "");
		return val;
	}
}
