package com.magicbeans.collaboration.common.freemarker.directive;

/**
 * @author Holen
 * @create 2016/12/21 15:59.
 */

import com.magicbeans.collaboration.Message;
import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import java.io.IOException;
import java.io.Writer;
import java.util.Map;

/**
 * 模板指令 - 瞬时消息
 *
 *
 *
 */
@Component("flashMessageDirective")
public class FlashMessageDirective extends BaseDirective {

    /**
     * "瞬时消息"属性名称
     */
    public static final String FLASH_MESSAGE_ATTRIBUTE_NAME = FlashMessageDirective.class.getName() + ".FLASH_MESSAGE";
//    public static final String FLASH_MESSAGE_ATTRIBUTE_NAME = "JINEN-FLASH_MESSAGE";

    /**
     * 变量名称
     */
    private static final String VARIABLE_NAME = "flashMessage";

    @Override
    @SuppressWarnings("rawtypes")
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body) throws TemplateException, IOException {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes != null) {
            Message message = (Message) requestAttributes.getAttribute(FLASH_MESSAGE_ATTRIBUTE_NAME, RequestAttributes.SCOPE_REQUEST);
            if (body != null) {
                setLocalVariable(VARIABLE_NAME, message, env, body);
            } else {
                if (message != null) {
                    Writer out = env.getOut();
                    out.write("Notify.message(\"" + message.getType() + "\", \"" + message.getContent() + "\");");
                }
            }
        }
    }
}