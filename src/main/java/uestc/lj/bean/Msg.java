package uestc.lj.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的返回的类
 *
 * @author crazlee
 */
public class Msg {
    //状态返回码
    private int code;
    //错误消息
    private String msg;
    //用户要返回给浏览器的数据
    private Map<String, Object> extend = new HashMap<>();

    /**
     * 访问成功
     *
     * @return
     */
    public static Msg success() {
        Msg success = new Msg();
        success.setCode(666);
        success.setMsg("处理成功！");
        return success;
    }

    /**
     * 访问失败
     *
     * @return
     */
    public static Msg failed() {
        Msg failed = new Msg();
        failed.setCode(233333);
        failed.setMsg("处理失败！");
        return failed;
    }

    public Msg add(String key, Object value) {
        this.getExtend().put(key, value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
