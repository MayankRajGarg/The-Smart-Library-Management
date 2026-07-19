package com.softwaretree.smartlibrary.model;

import org.json.JSONException;
import org.json.JSONObject;

import com.softwaretree.jdx.JDX_JSONObject;

/**
 * A shell (container) class parallel to a domain model object class for objects of type C 
 * based on the class JSONObject.  This class needs to define just two constructors.
 * Most of the processing is handled by the superclass JDX_JSONObject.
 * <p> 
 * @author Damodar Periwal
 *
 */
public class Book extends JDX_JSONObject {

    public Book() {
        super();
    }

    public Book(JSONObject jsonObject) throws JSONException {
        super(jsonObject);
    }

}
