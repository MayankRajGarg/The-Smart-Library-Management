package com.softwaretree.smartlibrary.model;

import org.json.JSONException;
import org.json.JSONObject;

import com.softwaretree.jdx.JDX_JSONObject;

/**
 * A shell (container) class parallel to a domain model object class for objects of type B 
 * based on the class JSONObject.  This class needs to define just two constructors.
 * Most of the processing is handled by the superclass JDX_JSONObject.
 * <p> 
 * @author Damodar Periwal
 *
 */
public class Member extends JDX_JSONObject {

    public Member() {
        super();
    }

    public Member(JSONObject jsonObject) throws JSONException {
        super(jsonObject);
    }

}
