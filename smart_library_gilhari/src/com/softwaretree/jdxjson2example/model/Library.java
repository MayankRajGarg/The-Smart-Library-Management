package com.softwaretree.jdxjson2example.model;

import org.json.JSONException;
import org.json.JSONObject;

import com.softwaretree.jdx.JDX_JSONObject;

/**
 * A shell (container) class parallel to a domain model object class for objects of type A 
 * based on the class JSONObject.  This class needs to define just two constructors.
 * Most of the processing is handled by the superclass JDX_JSONObject.
 * <p> 
 * @author Damodar Periwal
 *
 */
public class Library extends JDX_JSONObject {

    public Library() {
        super();
    }

    public Library(JSONObject jsonObject) throws JSONException {
        super(jsonObject);
    }

    // Relationship arrays
    public Book[] books;
    public Member[] members;
    public Staff[] staff;
    public LibraryTransaction[] librarytransactions;
}
