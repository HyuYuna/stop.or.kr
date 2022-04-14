package egovframework.dev.cmm.service;

import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;

import org.apache.log4j.Logger;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 공통 Mapper
 * @author 개발팀 진효진
 * @since 2017.10.31
 * @version 1.0
 * @see
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  ------------   --------    ---------------------------
 *  2017.10.31  진효진          최초 생성
 *  </pre>
 */

public class CmmMap extends EgovMap {

	private static final long serialVersionUID = 4622090551205091950L;
	private Logger log = Logger.getLogger(this.getClass());

	public CmmMap getFormMap() {
		return this;
	}
	public void setFormMap(CmmMap formMap) {
		this.clear();
		this.putAll(formMap);
	}

	public CmmMap getVoMap() {
		return this;
	}

	public void setVoMap(CmmMap voMap) {
		this.clear();
		this.putAll(voMap);
	}

	@Override
	public Object put(Object key, Object value) {
		if(key == null || key.toString().trim().length() < 1){
			return this;
		}
		if(value != null && value instanceof java.sql.Clob ) {
			super.put(key, getStringForClob( (Clob) value));
			return this;
		}
		if(value == null){
			value="";
		}
		super.put(key, value);
		return this;

	}

	public void set(Object key, Object value) {
		if(value != null && value instanceof java.sql.Clob ) {
			super.put(key, getStringForClob( (Clob) value));
			return;
		}
		super.put(key, value);
	}

	public void setBoolean(Object obj,boolean i ){
		boolean boolean1 = new Boolean(i);
		super.put(obj, boolean1);
	}

	public void setInt(Object obj, int i) {
		Integer integer = new Integer(i);
		super.put(obj, integer);
	}

	public void setDouble(Object obj, double d) {
		Double double1 = new Double(d);
		super.put(obj, double1);
	}

	public boolean getBoolean(Object obj){
		Object obj1 = super.get(obj);
		if(obj1==null)
			return Boolean.FALSE;
		else{
			if (obj1 instanceof Boolean)
				return ((Boolean) obj1).booleanValue();
			else if(obj1 instanceof String){
				try{
					return Boolean.parseBoolean(obj1.toString());
				}catch(Exception exception){
					log.error("obj1 instanceof String : " + exception);
				}
			}
		}
			return Boolean.FALSE;
	}
	public String getString(Object obj) {
		Object obj1 = super.get(obj);
		if (obj1 == null)
			return "";
		else
			return obj1.toString();
	}

	public int getInt(Object obj) {
		Object obj1 = super.get(obj);
		if (obj1 == null) {
			return 0;
		} else {
			if (obj1 instanceof Number)
				return ((Number) obj1).intValue();
			if (obj1 instanceof String)
				try {
					return Integer.parseInt(obj1.toString());
				} catch (Exception exception) {
					log.error("obj1 instanceof String : " + exception);
				}
		}
		return 0;
	}

	public double getDouble(Object obj) {
		Object obj1 = super.get(obj);
		if (obj1 == null) {
			return 0.0D;
		} else {
			if (obj1 instanceof Number)
				return ((Number) obj1).doubleValue();
			if (obj1 instanceof String)
				try {
					return Double.parseDouble(obj1.toString());
				} catch (Exception exception) {
					log.error("obj1 instanceof String : " + exception);
				}
		}
		return 0.0D;
	}

	@Override
	public Object get(Object key) {
		if(!this.containsKey(key))
			return "";

		return super.get(key);
	}



	/**
	 * java.sql.Clob to String return
	 * @param clob
	 * @return
	 */
	private String getStringForClob(Clob clob) {

        StringBuffer sbf = new StringBuffer();
        Reader br = null;
        char[] buf = new char[1024];
        int readcnt;
        try {
            br = clob.getCharacterStream();
            while ((readcnt=br.read(buf,0,1024))!=-1) {
                sbf.append(buf,0,readcnt);
            }
        } catch (Exception e) {
        	log.error("Failed to create String object from CLOB : " + e);
        }finally{
            if(br!=null)
                try {
                    br.close();
                } catch (IOException e) {
                	log.error("Failed to close BufferedReader object : " + e);
               }
        }
        return sbf.toString();
    }
}
